Return-Path: <stable+bounces-10396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA93828A98
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 18:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B490288C49
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 17:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35F23A8DB;
	Tue,  9 Jan 2024 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I78fOOmi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7857C3B193;
	Tue,  9 Jan 2024 17:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CD27C43394;
	Tue,  9 Jan 2024 17:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704819625;
	bh=iAPTyyyCWeHd3s4+fW9g7w85lBAUYH2W5DoFDR1FWwE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I78fOOmi6E3QxSZXUrtf8gj9tjgqB5UNx/pCcSxHYRTODOGoZGKx6b6OS0B5P2b0Q
	 UvoQK7sV3i58QBaAYqkTNPJC/JLfxeHJUWV0qctcG9D/9WFdt/IrXkEwgv3a6xH4K7
	 Z+HAF+MVwd/juKU0Erf08tJpGc0nE3uOd+Tmc3pGHeMUdgx/tTahzZJSSp2WDD1pKt
	 Xi4YIt+lOO6G3xQYmhsILjgb4hn/7SJPP8swYSJxSMg3e1Q0dLL7C2IrINShByDqgh
	 20/uMaavVO3ixtX9zFHX8Kah9m4LIr00lUIEb1JadW8UI7xScDu8sx9E+mnGeHtSYy
	 C+EGoXOYP0dpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1FF0DFC690;
	Tue,  9 Jan 2024 17:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/1] Bluetooth: hci_event: Fix wakeup BD_ADDR are wrongly
 recorded
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170481962498.3010.3880430812793729491.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jan 2024 17:00:24 +0000
References: <1704789450-17754-1-git-send-email-quic_zijuhu@quicinc.com>
In-Reply-To: <1704789450-17754-1-git-send-email-quic_zijuhu@quicinc.com>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 9 Jan 2024 16:37:30 +0800 you wrote:
> hci_store_wake_reason() wrongly parses event HCI_Connection_Request
> as HCI_Connection_Complete and HCI_Connection_Complete as
> HCI_Connection_Request, so causes recording wakeup BD_ADDR error and
> stability issue, it is fixed by this change.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> [...]

Here is the summary with links:
  - [v1,1/1] Bluetooth: hci_event: Fix wakeup BD_ADDR are wrongly recorded
    https://git.kernel.org/bluetooth/bluetooth-next/c/7974b2128489

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



