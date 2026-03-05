Return-Path: <stable+bounces-223221-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA5HHRqeqWnGAwEAu9opvQ
	(envelope-from <stable+bounces-223221-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 16:15:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C45D214490
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 16:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4CA6E3063800
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 15:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A8D3BED62;
	Thu,  5 Mar 2026 15:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqoumaku"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E966E3BED56;
	Thu,  5 Mar 2026 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772723486; cv=none; b=ejInQ9CuDo3+Sku9feC/00eiL28fpaqcLZ2q2uw3M4cqpMP7DA/SO+l73v0Qo5I7t3TouUKDMI92ox1t+NfKFksv3vK7aXlJwXuNTijZ+CpUbxKCFjSZ1LVskVgH8VdB/i1+BEZA1NkhRSwH9VozdSS8My98bBFKqyq7heyxxSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772723486; c=relaxed/simple;
	bh=jcIirNfvPF4is55BJMcKQpkNSljuPtzois/VbU8KCUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRaePp4DkW99oOv3gTVigG7Jx8Uljq8lGAf7TriUyhnLa/USGK1zlIDlYV8pQYhbpfPHEYLnBsTBCj5FxYhEG6/rKJUoMrpjkPc59TetFgLtfejk50JupcS6uHLuAgRvosTmVVrmaAE13VJyqB1SHQ1bUIFWN5FC5cdJrngbDuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqoumaku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1093DC19423;
	Thu,  5 Mar 2026 15:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772723485;
	bh=jcIirNfvPF4is55BJMcKQpkNSljuPtzois/VbU8KCUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gqoumakuq2xIqASoisZwyW0AWOo63pl9678mFWJ0KKeIBXlZnzUapVdCVQEO5vj3c
	 iW2LG1/iwpQGehMvVn7I7O2us/bxDrVbyusceoSLsJkdHVyAUHls4YOq1Hv/Ry4Ih6
	 AvZm8iXztxw5x5gqyvUPM3NiFKUS7PUscBL7n8vsm/fB+B0w1y64jesmpUXdRVUCxp
	 j89GUqOCkGiMHlb89q92CgpVGJGd6RIh7uemodA/VEV0YJk2uhQSQPy19ZIRNXQf3/
	 6AYSrGszkUdotsfyRJh9f2HNRQ4NsyCX6H4+jYpvOsecmXZ0Z1L5XaM+gziOvqm/nT
	 ir5cVvp+60sew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	gregkh@linuxfoundation.org
Subject: Re: Linux 6.6.129
Date: Thu,  5 Mar 2026 10:11:22 -0500
Message-ID: <20260305151122.672890-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305151122.672890-1-sashal@kernel.org>
References: <20260305151122.672890-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2C45D214490
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223221-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

diff --git a/Makefile b/Makefile
index f7157576539da..022aed9031737 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 128
+SUBLEVEL = 129
 EXTRAVERSION =
 NAME = Pinguïn Aangedreven
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index df74f865c9f12..eb129277dcdd6 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -372,15 +372,9 @@ int __init ima_free_kexec_buffer(void)
 
 int __init ima_get_kexec_buffer(void **addr, size_t *size)
 {
-	int ret;
-
 	if (!ima_kexec_buffer_size)
 		return -ENOENT;
 
-	ret = ima_validate_range(ima_kexec_buffer_phys, ima_kexec_buffer_size);
-	if (ret)
-		return ret;
-
 	*addr = __va(ima_kexec_buffer_phys);
 	*size = ima_kexec_buffer_size;
 

