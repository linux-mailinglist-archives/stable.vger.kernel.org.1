Return-Path: <stable+bounces-132141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFDBA84900
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32E917ED33
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D504B1EBFEB;
	Thu, 10 Apr 2025 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxjrzbCV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C6D1E9B38
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300412; cv=none; b=NeUg2ANLhgb5n+kNn/Xix1VZWgkZIyhLE3UaPVexReMhazrarOk3Y1LD5v3e1LnNw45MNid6v5bhmTg9r05qCJWubu2/rIqV1deDtx3SxRDxJCWqgq1RVZLWTaJBEzSN79o9e0uxucDOuuidTwVsE/NpOdPdJ0qv6yj1mJILfnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300412; c=relaxed/simple;
	bh=rfrxhcdwt6lAA2bSI87D9e0RLWut00c53/cKkCNzNPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9fLwpKw7bNlcPCbkTrYgvnKHEp7bPvuSx+VVYQ1Ei+CV+MRHPxLX1xk1MYcohi2x3oZfI7jRd+4fq2ydbl/4n4w3kKcaTiJ33J9aLAN3Mc7vMjrrLd2YHkY6u7gi9z75KQREgIteqavMf+QWbMrR2IwgEFNZGmh0jMbafdie6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxjrzbCV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E233FC4CEDD;
	Thu, 10 Apr 2025 15:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300412;
	bh=rfrxhcdwt6lAA2bSI87D9e0RLWut00c53/cKkCNzNPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fxjrzbCVXw04jn/b8vTum+JKiCclcACJY9aNZAuJ7+nu+GoZEa0FycvhCZ/nsK/hi
	 WPxmLGKuu4dcKXd7Urfcb2eBaOMl+ULpy4p0I15uQUs9OeuPTLPugZycGXGnLM92e8
	 z7zclFKSJWkJ51siTxlz3H1RcYsQ5Ck5azK4PuSEQ4SAsNjQiBhCO2X636IC7nWx2p
	 fJIYU/D9QuqXv+BKhBXk4V2u8x1u6YyjrZqu34JBzvOa68stxTCQMW1s9zNB6ZRQBb
	 c1VsSfjknSEIDygWW0+XVUj1vrJ0YJhoXSrz8ejiUXOJCLj47LuTGL2U32q+2rLMl6
	 S1XD6YKaDMQgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10/5.15] Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE
Date: Thu, 10 Apr 2025 11:53:30 -0400
Message-Id: <20250410075438-0440ea38a354d17b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250410080917.2121970-1-xiangyu.chen@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: b25e11f978b63cb7857890edb3a698599cddb10e

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen<xiangyu.chen@eng.windriver.com>
Commit author: Luiz Augusto von Dentz<luiz.von.dentz@intel.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 830c03e58beb)
6.1.y | Present (different SHA1: d17c631ba04e)
5.15.y | Present (different SHA1: fc37ccc52a5f)

Note: The patch differs from the upstream commit:
---
1:  b25e11f978b63 ! 1:  008d8b083b73c Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE
    @@ Metadata
      ## Commit message ##
         Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE
     
    +    commit b25e11f978b63cb7857890edb3a698599cddb10e upstream.
    +
         This aligned BR/EDR JUST_WORKS method with LE which since 92516cd97fd4
         ("Bluetooth: Always request for user confirmation for Just Works")
         always request user confirmation with confirm_hint set since the
    @@ Commit message
         Fixes: ba15a58b179e ("Bluetooth: Fix SSP acceptor just-works confirmation without MITM")
         Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
         Tested-by: Kiran K <kiran.k@intel.com>
    +    Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## net/bluetooth/hci_event.c ##
    -@@ net/bluetooth/hci_event.c: static void hci_user_confirm_request_evt(struct hci_dev *hdev, void *data,
    +@@ net/bluetooth/hci_event.c: static void hci_user_confirm_request_evt(struct hci_dev *hdev,
      		goto unlock;
      	}
      
    @@ net/bluetooth/hci_event.c: static void hci_user_confirm_request_evt(struct hci_d
     -		    conn->io_capability != HCI_IO_NO_INPUT_OUTPUT &&
     -		    (loc_mitm || rem_mitm)) {
     +		    conn->io_capability != HCI_IO_NO_INPUT_OUTPUT) {
    - 			bt_dev_dbg(hdev, "Confirming auto-accept as acceptor");
    + 			BT_DBG("Confirming auto-accept as acceptor");
      			confirm_hint = 1;
      			goto confirm;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |

