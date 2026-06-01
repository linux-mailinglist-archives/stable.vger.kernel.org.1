Return-Path: <stable+bounces-259526-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHXcCbNmHWrqaAkAu9opvQ
	(envelope-from <stable+bounces-259526-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 13:02:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9334161E0BC
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 13:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8829300826F
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 11:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4459389455;
	Mon,  1 Jun 2026 11:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyfpuF72"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5E4346AFB
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 11:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780311728; cv=none; b=s6Kih/j/Qu9g87/EOLAaJ9DK7SgBkw3l3E9v/csUsIKZxXJm5r4EZ2JWbmdQThHoS1YCKsdI8INRglQ/yM+Vcbj56QRZ0Nk000IphawXM2a18xnvXUGpWCG5E7/UNYoao4sh+DMxY8Fq99Lehyp7QAVoQNCUCuU6J9TLjDSOGeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780311728; c=relaxed/simple;
	bh=a/V/ZqsOru2Y9J+du0DU8mxrAJPAFgnbdOWSA1IOYQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLwnFi6kjRH1CW7p7smldigJg1s0KBbZF6ZIbEplHIm3IUh04IJtGFUjSAizcSsAJmx77VQ+jBDLlXwQpo8UmHnmWznQmtLghiEulHrldtUE3EePiBAOeGlOsyF6ZKoOxoyq8fyWYmkmqB4n1opN2zagVp7maMdvyX0+9dZnUJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyfpuF72; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59D01F00899;
	Mon,  1 Jun 2026 11:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780311727;
	bh=v7hlWWnWKATPA2BFRktGbl7qtTgWhJ7ZNc0XU1ZwKic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oyfpuF72BVq+MWpnkZnAxryEi4GzTa4wLDS5hiCABoD2UbHZeLBPcsaX9LRJBJ9cd
	 V6daTTYAgmnlrNdfNrFXTI36DF+rsm5H/x7k4+dbaSl04vz4PWE4ZBxAwvuVZL6f3h
	 t1TZ4Uv8Pfv+jSmQO050APDweNzHZv7eoxblUwLXbglIe0yMy9QvOq8HaJpYPs8s2I
	 FarGqTjGpuHO9q2lFCM8NiZVpQUrdzsdj/e9i+lu6rJEJWqJwbhu867V42rOG2f/3O
	 5Ql8tVcXqGio51coKGNEJD+lHGYvWAOPby9OgJYdahbmzVM+VC2+0hp70Cp/MPFKXt
	 icGMMuYnY3eNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Henry Tseng <henrytseng@qnap.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] cpufreq: intel_pstate: Use correct scaling factor on Raptor Lake-E
Date: Mon,  1 Jun 2026 07:02:04 -0400
Message-ID: <20260601110204.439565-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601110204.439565-1-sashal@kernel.org>
References: <2026052846-jasmine-recess-d8cc@gregkh>
 <20260601110204.439565-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259526-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 9334161E0BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 0e7c710478b3089cdfe8669347f77b163e836c4f ]

Raptor Lake-E has the same processor ID as Raptor Lake-S, so there is
an entry in intel_hybrid_scaling_factor[] for it.  It does not contain
E-cores though and hybrid_get_cpu_type() returns 0 for its P-cores, so
they get the default "core" scaling factor.  However, the original
Raptor Lake scaling factor for P-cores still needs to be used for
mapping the HWP performance levels of the P-cores in Raptor Lake-E to
frequency, as though they were part of a real hybrid system.

To address this, update hwp_get_cpu_scaling() to return
hybrid_scaling_factor, which is the P-core scaling factor
retrieved from intel_hybrid_scaling_factor[], for all CPUs
that are not enumerated as E-cores.

Fixes: 9b18d536b124 ("cpufreq: intel_pstate: Use CPPC to get scaling factors")
Link: https://lore.kernel.org/all/20260511235328.2018458-1-srinivas.pandruvada@linux.intel.com/
Reported-by: Henry Tseng <henrytseng@qnap.com>
Closes: https://lore.kernel.org/linux-pm/20260508063032.3248602-1-henrytseng@qnap.com/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: All applicable <stable@vger.kernel.org>
Link: https://patch.msgid.link/4523296.ejJDZkT8p0@rafael.j.wysocki
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 6e1a793408dee..7fb6412b5f193 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2308,7 +2308,7 @@ static int hwp_get_cpu_scaling(int cpu)
 		 * Return the hybrid scaling factor for P-cores and use the
 		 * default core scaling for E-cores.
 		 */
-		if (hybrid_get_cpu_type(cpu) == INTEL_CPU_TYPE_CORE)
+		if (hybrid_get_cpu_type(cpu) != INTEL_CPU_TYPE_ATOM)
 			return hybrid_scaling_factor;
 
 		return core_get_scaling();
-- 
2.53.0


