Return-Path: <stable+bounces-218575-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMe+EwJYnmkjUwQAu9opvQ
	(envelope-from <stable+bounces-218575-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:01:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A78FF190673
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71324315CF2F
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1DC248881;
	Wed, 25 Feb 2026 01:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D8tdiAo0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE091FE45D;
	Wed, 25 Feb 2026 01:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983417; cv=none; b=apvCMhykUFY0JySOveKjCX2Fp/V8CATd4PpKEbiYAI3BIGno+8UGaK1GJFMjWkH+vqD8uCFQzjxkwkR+39x2+Wlj7z1p5QicUtfaAkO5aXzLCbN0CbeTtyvSHhAJykj7W31UnDJXkako5CYxQqTJ3RIFJwKGrckEw5bO9b+Bu+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983417; c=relaxed/simple;
	bh=x9iU/W3jXjMBb4GaGDSYBDJC3V2Mj8TNnQm65bJFqAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LeEWZj9hGMfpY+XFzzN7YRuvfX4NIV99+/CI4zp02/a9fUdomWP7ps4nIo4mIxb1maq2JLuNR6g4eS7UnDHthWH+db1A0TmbZ7bkFkX+UqdSmoV06lF1jCTC/paDd9mthmchgl2ZPlc4hca58KVaC9ECZAAMjwcXDHdGbwWdVB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D8tdiAo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34376C116D0;
	Wed, 25 Feb 2026 01:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983417;
	bh=x9iU/W3jXjMBb4GaGDSYBDJC3V2Mj8TNnQm65bJFqAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D8tdiAo06zgEeNGSxBdSUTShOPNDE6QlPA4Q9IbfwxvAPfvK5rm00XNze5XIgKxze
	 rawLGAaz3JB/koXczdsvvHymQDcoitHxUTEjpgYZMqnrRDYQmUAbo1XSB9vJ8Xogbz
	 sxeU0fmc5psbYAbeTcQ+ulI6e1thJGmhhO8QZQ/c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Brian Masney <bmasney@redhat.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 538/781] clk: qcom: gfx3d: add parent to parent request map
Date: Tue, 24 Feb 2026 17:20:47 -0800
Message-ID: <20260225012412.993116855@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218575-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: A78FF190673
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

[ Upstream commit 2583cb925ca1ce450aa5d74a05a67448db970193 ]

After commit d228ece36345 ("clk: divider: remove round_rate() in favor
of determine_rate()") determining GFX3D clock rate crashes, because the
passed parent map doesn't provide the expected best_parent_hw clock
(with the roundd_rate path before the offending commit the
best_parent_hw was ignored).

Set the field in parent_req in addition to setting it in the req,
fixing the crash.

 clk_hw_round_rate (drivers/clk/clk.c:1764) (P)
 clk_divider_bestdiv (drivers/clk/clk-divider.c:336)
 divider_determine_rate (drivers/clk/clk-divider.c:358)
 clk_alpha_pll_postdiv_determine_rate (drivers/clk/qcom/clk-alpha-pll.c:1275)
 clk_core_determine_round_nolock (drivers/clk/clk.c:1606)
 clk_core_round_rate_nolock (drivers/clk/clk.c:1701)
 __clk_determine_rate (drivers/clk/clk.c:1741)
 clk_gfx3d_determine_rate (drivers/clk/qcom/clk-rcg2.c:1268)
 clk_core_determine_round_nolock (drivers/clk/clk.c:1606)
 clk_core_round_rate_nolock (drivers/clk/clk.c:1701)
 clk_core_round_rate_nolock (drivers/clk/clk.c:1710)
 clk_round_rate (drivers/clk/clk.c:1804)
 dev_pm_opp_set_rate (drivers/opp/core.c:1440 (discriminator 1))
 msm_devfreq_target (drivers/gpu/drm/msm/msm_gpu_devfreq.c:51)
 devfreq_set_target (drivers/devfreq/devfreq.c:360)
 devfreq_update_target (drivers/devfreq/devfreq.c:426)
 devfreq_monitor (drivers/devfreq/devfreq.c:458)
 process_one_work (arch/arm64/include/asm/jump_label.h:36 include/trace/events/workqueue.h:110 kernel/workqueue.c:3284)
 worker_thread (kernel/workqueue.c:3356 (discriminator 2) kernel/workqueue.c:3443 (discriminator 2))
 kthread (kernel/kthread.c:467)
 ret_from_fork (arch/arm64/kernel/entry.S:861)

Fixes: 55213e1acec9 ("clk: qcom: Add gfx3d ping-pong PLL frequency switching")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Brian Masney <bmasney@redhat.com>
Link: https://lore.kernel.org/r/20260117-db820-fix-gfx3d-v1-1-0f8894d71d63@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/clk-rcg2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 2838d4cb2d58e..d0a5847f91114 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -1264,6 +1264,7 @@ static int clk_gfx3d_determine_rate(struct clk_hw *hw,
 	if (req->max_rate < parent_req.max_rate)
 		parent_req.max_rate = req->max_rate;
 
+	parent_req.best_parent_hw = req->best_parent_hw;
 	ret = __clk_determine_rate(req->best_parent_hw, &parent_req);
 	if (ret)
 		return ret;
-- 
2.51.0




