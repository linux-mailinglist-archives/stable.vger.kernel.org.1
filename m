Return-Path: <stable+bounces-219978-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CB6Jpq4oWkYwAQAu9opvQ
	(envelope-from <stable+bounces-219978-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 16:30:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAC61B9CD0
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 16:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BA2F309614B
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 15:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BB643CED1;
	Fri, 27 Feb 2026 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2Ezk2uk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E13543CEF9;
	Fri, 27 Feb 2026 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205920; cv=none; b=alq8v/+5gA9vBVtGnFHXBKScTzhtd9CthVapVrz5lhq3tCggOFOdy2ef4C1Pj7ocNFJQGa0R/L3USLRspSgATLoHKa9GWAMlVhBDi3/Vm5IhhofLR3zsPDz53b5b5QMUxJExy0immDvDIrn/Vpu5AFo8Oe+is2nyztME/NKFii8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205920; c=relaxed/simple;
	bh=Bc6ey6BciWe8j+lygwR6SguBwgrGyUpx6yTMtHUcUbE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fGNR+haQdNjIkb/R6OHqphKUhxVH5toQ5ANfmrgSWwuPyyFYBzXndQAgejArZI0GpHzHIsr0jBQdT6ZyucpM9lZP6Zpoxh4KhIr1IhbuVzdVQahzlMjPR7XMU4t8cdcdi5kH2vToKkEjs5YDzMK5comS8wkjJyuzCSNsWfKiSSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2Ezk2uk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE6EC19423;
	Fri, 27 Feb 2026 15:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772205920;
	bh=Bc6ey6BciWe8j+lygwR6SguBwgrGyUpx6yTMtHUcUbE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=l2Ezk2ukU93E43oi9MedovJMkO/bLQpXeaZflfxaFo/grNAkasW3KLa+fa0z59eS2
	 3CHR6fWt/kxicq5sE5hW96qSYm7pft7zlPgYqV1VWpPvQMZCKzmxWgzM/xuHHOYf6p
	 PylMA9JDFQt5ai+okFgnO15XQyo7ReQimkAxatvrHyvGuyEJYpCi6r7lrn8el5h7yy
	 UmIC540PKKrNTzw9ulR4QQ0cOEBTiISuq+dR81hTZ20BB/K3iWsKUoe8z0qwJYbzPo
	 XQVYoJezVGvy9TcRTm8igqDCDo+I/w1OdTGZlqgv6aK8eikMf+14Ylj2YIYIMAicSe
	 LnBftPUjVy3yg==
From: Vinod Koul <vkoul@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Nitin Rawat <nitin.rawat@oss.qualcomm.com>
In-Reply-To: <20260219-phy-qcom-qmp-ufs-fix-sm8650-pcs-g4-table-v1-1-f136505b57f6@oss.qualcomm.com>
References: <20260219-phy-qcom-qmp-ufs-fix-sm8650-pcs-g4-table-v1-1-f136505b57f6@oss.qualcomm.com>
Subject: Re: [PATCH] phy: qcom: qmp-ufs: Fix SM8650 PCS table for Gear 4
Message-Id: <177220591758.320398.17176823670810946893.b4-ty@kernel.org>
Date: Fri, 27 Feb 2026 20:55:17 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219978-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3CAC61B9CD0
X-Rspamd-Action: no action


On Thu, 19 Feb 2026 13:11:48 +0200, Abel Vesa wrote:
> According to internal documentation, on SM8650, when the PHY is configured
> in Gear 4, the QPHY_V6_PCS_UFS_PLL_CNTL register needs to have the same
> value as for Gear 5.
> 
> At the moment, there is no board that comes with a UFS 3.x device, so
> this issue doesn't show up, but with the new Eliza SoC, which uses the
> same init sequence as SM8650, on the MTP board, the link startup fails
> with the current Gear 4 PCS table.
> 
> [...]

Applied, thanks!

[1/1] phy: qcom: qmp-ufs: Fix SM8650 PCS table for Gear 4
      commit: 81af9e40e2e4e1aa95f09fb34811760be6742c58

Best regards,
-- 
~Vinod



