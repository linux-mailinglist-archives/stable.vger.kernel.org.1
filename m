Return-Path: <stable+bounces-134517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 880CEA92FCD
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 04:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE398A44C6
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 02:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3303F2641DE;
	Fri, 18 Apr 2025 02:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="mCVnWDLp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="miclJpit"
X-Original-To: stable@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC7E17C219
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 02:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744942545; cv=none; b=ArIz/CJJB94AkAQswdMby5c8ke5NbDxIn/OuYTj5CuH+o0YZ1ocVHxvsLsfQo8y+emTAyDPxsG3rGITRUpi+qYv09KVTNEVMBjQlzaH9Gikm33utJoFmRz/xlTNxeU5prIBCmf8CLcrJN7fM7nx9i5KaSaU+jBarwuCtGdx7t34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744942545; c=relaxed/simple;
	bh=TDhYEwGphfMvuHXzeH1DDt0Mq2n3bxxEeFfbVOcVQ9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MnhO9akhJ6igdg5cJu7wKsqe88Dnloddjqs+035d1dmSxjjo8DCTpiT/AwVmmUasr55eAi9xLzyU62XRXxSCHAry+oD9Fasg3Vq6oVcZ3zN86E6jRMD0YrK2yBKBxVzJC/YLFyh6fWDnlKN7m+iskQAJb2rWSG79FKjDrEIodp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=mCVnWDLp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=miclJpit; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id CC9D811400DB;
	Thu, 17 Apr 2025 22:15:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 17 Apr 2025 22:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744942541; x=1745028941; bh=H96fh9P+tY
	R/Dy3/8BJxs52FniFBtouCyFv3/K8Fpzc=; b=mCVnWDLpFqDnbuvUXduqYvb/BU
	ULw/eOjN1ot0N79mA4YBqGhNJW0QvNX6HqkJsHQzvheespEl2yE2unWr8dZ2hj9S
	SBiVg1TYTk7WxgPfrpsOokwYmHIkmJjbdzfJZ+25eTHN+14kBj5nuTKvSVMVL7m3
	7GJZMaHt392XpwwdmxTzmA7dpSiODZN2hSM8XCAotPe3u1QPx+Y+y0Fb9vk4Q63M
	31nDpSPkTZ1j/J6gxA7IifRyJFTs4uupuuIo+ZPoc6p7T9AJYxtvoPj0S1LSqXUP
	OnOnZNn16ztGuS+OSujvvhjv4RlrK4AZuXkAeITbyYplaheqZqohQO/FV4WA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744942541; x=
	1745028941; bh=H96fh9P+tYR/Dy3/8BJxs52FniFBtouCyFv3/K8Fpzc=; b=m
	iclJpithvIz9DGWc9XqUV9WcWDGvqlyButZ2p8rcKcjnLFZSI7FevTrIWFOQR2Mh
	AE6YP7lDL2M15SMd+LvwYp3WugfdveNnjh/EwP6Us7D5pAr/jsZLAoL03S1mrtvH
	vmkCHdfYvbTGTe9wp+l21IMWFnIC7YB2DQwab6ulMYZXF+jR9AogTL+QFh5LbV0O
	0Nze7fywHT6oZrLteWeaLj9boqCDm1Ctc0KoODNXtQsjP1YBMr+R3VDcj305b15X
	eG/Hl8T8S/fPIHAVWHDmkWxMOQ70O5xjKNE/PR4HED6ayUImou4kTJceVLYfNMOk
	ZP8s2vYPKu4DZoDW8RcMA==
X-ME-Sender: <xms:zbUBaK865Qigi2JaDbFQBgZLuARIVPIbj3t0NSrGn1ybToHYATzqlA>
    <xme:zbUBaKtSnd8MR4AxcCvfdgRChHuASd_N_tj6baa-WPBs_p0qs_PAd79Nn8CazfLp_
    b_S0NeemQwI8Q>
X-ME-Received: <xmr:zbUBaAAtRgUWP4gPPpO7AY-4VNjJd0mEmxgqj8r-kHvdlW5DqpqKko4X-vx3VGz2xSIfuolze8J58l1nj_86A_L0Cb8IacOwqg-SaC81Klj7U3Nb7rE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedtleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertder
    tdejnecuhfhrohhmpeforghrvghkucforghrtgiihihkohifshhkihdqifpkrhgvtghkih
    cuoehmrghrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhmqeen
    ucggtffrrghtthgvrhhnpedttdeitefhvdeguedtheettdeuudelteelfffgudehheeivd
    euuedtkeelteelveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhmshhgihgurdhl
    ihhnkhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrghrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhmpdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgrsghlvg
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlhdrjhdrfiih
    shhotghkihesihhnthgvlhdrtghomhdprhgtphhtthhopehmrghrmhgrrhgvkhesihhnvh
    hishhisghlvghthhhinhhgshhlrggsrdgtohhmpdhrtghpthhtohepvhhirhgvshhhrdhk
    uhhmrghrsehlihhnrghrohdrohhrgh
X-ME-Proxy: <xmx:zbUBaCeVMgxjoK3B0C32toD3UNd88KKzTLPLY7EemeCpCQN15_KN8Q>
    <xmx:zbUBaPNPwjGjB1bwyd_4qA751YDM4Oeb_k4MZOT99NSNPcmj2hmaEQ>
    <xmx:zbUBaMn4erL3sxbrx3_7j6He2QHkEuoI_eo15flZcQRO9rrlhnsPwQ>
    <xmx:zbUBaBsVypNXeUNFl-Cum2280WqYeOkdTDn2Sq3SmTB4gc9h3tjufw>
    <xmx:zbUBaMzdk_VwQE4dkKdLPhx14aIM79nrxfu7ACUS2MxQKj9Q6dCcX1lj>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 22:15:40 -0400 (EDT)
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	=?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 6.14.y and others] cpufreq: Reference count policy in cpufreq_update_limits()
Date: Fri, 18 Apr 2025 04:15:13 +0200
Message-ID: <20250418021517.1960418-1-marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025041714-stoke-unripe-5956@gregkh>
References: <2025041714-stoke-unripe-5956@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Since acpi_processor_notify() can be called before registering a cpufreq
driver or even in cases when a cpufreq driver is not registered at all,
cpufreq_update_limits() needs to check if a cpufreq driver is present
and prevent it from being unregistered.

For this purpose, make it call cpufreq_cpu_get() to obtain a cpufreq
policy pointer for the given CPU and reference count the corresponding
policy object, if present.

Fixes: 5a25e3f7cc53 ("cpufreq: intel_pstate: Driver-specific handling of _PPC updates")
Closes: https://lore.kernel.org/linux-acpi/Z-ShAR59cTow0KcR@mail-itl
Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://patch.msgid.link/1928789.tdWV9SEqCh@rjwysocki.net
(cherry picked from commit 9e4e249018d208678888bdf22f6b652728106528)
[do not use __free(cpufreq_cpu_put) in a backport]
Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
This patch is applicable to other stable branches too.
---
 drivers/cpufreq/cpufreq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 30ffbddc7ece..934e0e19824c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2762,10 +2762,18 @@ EXPORT_SYMBOL(cpufreq_update_policy);
  */
 void cpufreq_update_limits(unsigned int cpu)
 {
+	struct cpufreq_policy *policy;
+
+	policy = cpufreq_cpu_get(cpu);
+	if (!policy)
+		return;
+
 	if (cpufreq_driver->update_limits)
 		cpufreq_driver->update_limits(cpu);
 	else
 		cpufreq_update_policy(cpu);
+
+	cpufreq_cpu_put(policy);
 }
 EXPORT_SYMBOL_GPL(cpufreq_update_limits);
 
-- 
2.49.0


