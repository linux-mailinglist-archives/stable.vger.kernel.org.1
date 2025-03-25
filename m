Return-Path: <stable+bounces-126020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FC7A6F43A
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC26916695A
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BC41EA7F5;
	Tue, 25 Mar 2025 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQQNBxTE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671F3BA36
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902422; cv=none; b=HL8UwIVIw/sF5tWynx9rY6PKHgGCs/6LNmn3rRgYM6oRNFCvkYpjWMbDf9KjKJm4w46QDub++/DD+UdgmkSvhQmTfj0KAnuM0SuWH8LwX6kUDQBZrFPhNV95EM0+wEMn5bl7LWzaIfyPWMiLYfsdKmsXHQy0oKKdmcbMPcOQw0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902422; c=relaxed/simple;
	bh=gnCjWKKIDS5dSUoXT8hCvpfOnPidpYjjiiRg2NVx+PI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mzcFNkTg5kkuAgIEdBlavxJM7eOzNRAXZuZTf4OZyFNxJp62WPbgWAWjXteg48C+Zbba3aQ8c0Bj81k8XbJCOs5J77JXuEKO6A3hidMaSkKu/nrKqKn8jUdXU+xPtTLpIUY7AC1mDh5m+Q2OGr+L7XyhBjmI/Kp7bgza9D/gkV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQQNBxTE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E30C4CEE4;
	Tue, 25 Mar 2025 11:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902420;
	bh=gnCjWKKIDS5dSUoXT8hCvpfOnPidpYjjiiRg2NVx+PI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EQQNBxTELUlEIPOHjPNOrmBJDjZaWkOFt8z8YyOKGZEGObrq96feuM7AF/dlwlgla
	 m0KNXKWn3tef5Wl9TxwuvwpjgCzA42UfiYnAiEL1XyC8hpTDpFxRAHXXNQ1vMBz/su
	 3LVS2wFHNmdrf6febwGfxXngC24yxID02Bgvn9f2DAHv2IFC0sz83/s1fAdFGAuWMC
	 /SYsxtr5Vq4/N9+R4Vf2iLgsGtVMOKTWkN9p1G81eInXTS359tFwArVbDxfwaWYYg2
	 copfJGZpGbn65xEC/nATKibHE1J8XrP1vutEjEsTSrEPF1GfdR/inLHPeRZIf5KIE1
	 XeKlE+1oU/ogg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE
Date: Tue, 25 Mar 2025 07:33:39 -0400
Message-Id: <20250324214447-cc49f7f8b4749281@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250324074150.1067219-1-bin.lan.cn@windriver.com>
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
Backport author: bin.lan.cn@windriver.com
Commit author: Luiz Augusto von Dentz<luiz.von.dentz@intel.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 830c03e58beb)
6.1.y | Present (different SHA1: d17c631ba04e)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  b25e11f978b63 ! 1:  e762714d6fe68 Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE
    @@ Metadata
      ## Commit message ##
         Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE
     
    +    [ Upstream commit b25e11f978b63cb7857890edb3a698599cddb10e ]
    +
         This aligned BR/EDR JUST_WORKS method with LE which since 92516cd97fd4
         ("Bluetooth: Always request for user confirmation for Just Works")
         always request user confirmation with confirm_hint set since the
    @@ Commit message
         Fixes: ba15a58b179e ("Bluetooth: Fix SSP acceptor just-works confirmation without MITM")
         Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
         Tested-by: Kiran K <kiran.k@intel.com>
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
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

