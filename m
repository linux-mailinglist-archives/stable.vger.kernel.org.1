Return-Path: <stable+bounces-220615-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMVtE7xQo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220615-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:31:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C66111C8692
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C74583788F81
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457B93E5598;
	Sat, 28 Feb 2026 17:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwyNQYxf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A873E558F;
	Sat, 28 Feb 2026 17:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300499; cv=none; b=HvEt93gLXOmu49kE9EWKwSgxs/goCh1fFJ6nMk6jkHlQ6ygCKKAOIL2CpiMBL6u/vHnu58JUoHb0O5I91PkugWPCsPx+wfDW+/f1wYgHRh50DPrzkjTG0nZHaL8QtGnpVr6meJY70S0gmxmx/Ic7YLWAGb2UVExZjgQHQxRS9AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300499; c=relaxed/simple;
	bh=lcawo1snmYO4JkAn7IB+DhZ12UD686+CTTT4COmR6yE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtWuyL+2REAE9DwfgoQ/Fd+DealnYVjHtpXoAK7hN+f3RAz7GkvPzXQ9ROB0cF2ME/PrLYkazIlR3NJsVvaeUrLlm1tuQHY7+BPhog6T+4VIgTNRYMcX7GmrnMsDomRw72tYas5lukpaCRyNg/VkknDL6eRFzrn1FtfjiHvtlPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwyNQYxf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03926C116D0;
	Sat, 28 Feb 2026 17:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300498;
	bh=lcawo1snmYO4JkAn7IB+DhZ12UD686+CTTT4COmR6yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IwyNQYxfMl4ZjAaLdEpqYQas04OtobQqKGKRlsi8+nPo5D0RB7FUGfkqlYWe0N1Gq
	 b5yD03ONIXrRjhNrpqDCscj4AfpOyKKkQv0UIYhGWxbH5LkLbaqYKq8eKghRHi2lwf
	 gz9u5ajUoqGXwHCNGac0j3dc0INSr4OjR7FZLwRMdkQDKu0yJqwxnLvHDzYqRWBqBi
	 1x5MJkZhQlBj5LgLXRVvvG6h+BN99tSCF/E3oLr93vXArqnxpCCyMjRTHVJEGWc+W5
	 l0tbFnB0E/KxbKXiJzp9iuE3fydene4rbNR1sJ4ELBR1pkEWboyaM7CrGEYFRHLi1W
	 tIyss/u0yGjjw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexey Minnekhanov <alexeymin@postmarketos.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 536/844] arm64: dts: qcom: sdm630: Add missing MDSS reset
Date: Sat, 28 Feb 2026 12:27:29 -0500
Message-ID: <20260228173244.1509663-537-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220615-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,c900000:email,postmarketos.org:email]
X-Rspamd-Queue-Id: C66111C8692
X-Rspamd-Action: no action

From: Alexey Minnekhanov <alexeymin@postmarketos.org>

[ Upstream commit 0c1d1591f898d54eaa4c8f2a1535ab21bf4e42e4 ]

If the OS does not support recovering the state left by the
bootloader it needs a way to reset display hardware, so that it can
start from a clean state. Add a reference to the relevant reset.

It fixes display init issue appeared in Linux v6.17: without reset
device boots into black screen and you need to turn display off/on
to "fix" it. Also sometimes it can boot into solid blue color
with these messages in kernel log:

  hw recovery is not complete for ctl:2
  [drm:dpu_encoder_phys_vid_prepare_for_kickoff:569] [dpu error]enc33
      intf1 ctl 2 reset failure: -22
  [drm:dpu_encoder_frame_done_timeout:2727] [dpu error]enc33 frame
      done timeout

Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sync_state")
Cc: stable@vger.kernel.org # 6.17
Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20251116-sdm660-mdss-reset-v2-3-6219bec0a97f@postmarketos.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index b383e480a394d..876a6871745cf 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1563,6 +1563,7 @@ mdss: display-subsystem@c900000 {
 			reg-names = "mdss_phys", "vbif_phys";
 
 			power-domains = <&mmcc MDSS_GDSC>;
+			resets = <&mmcc MDSS_BCR>;
 
 			clocks = <&mmcc MDSS_AHB_CLK>,
 				 <&mmcc MDSS_AXI_CLK>,
-- 
2.51.0


