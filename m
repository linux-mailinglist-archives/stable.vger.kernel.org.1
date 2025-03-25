Return-Path: <stable+bounces-126018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7189A6F428
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2EF93B7EA0
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935B02561A2;
	Tue, 25 Mar 2025 11:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVMJaX43"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54086255E47
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902417; cv=none; b=bG5b79D2nn369uB4t/9ywULXoB38qBL6T/fMeOI0xgyQLmHE+Ed0MI+YBMeKbxEyL6cdHGLC1+0p1eytpc/aZLC+nOQ/J4w7XIEuwIfRvvc8KTZ11Qv3LIELL7jKL/NVW/Hj6i/lMuLhJDgqSy8IH6DJ8ZtPZlru7P/F+DwZ1X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902417; c=relaxed/simple;
	bh=gUwSqRzMewDR6wgCqf6ynUzSFJs+WOdVR3q+skT2IAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AssTcHsdvu+eBPQ6TX88eVbcozcgjlEFyEmTMmnRTq3Fytv90HnSr3erYvChX96N4mwXGaCIGnPH6uBnIZHEzM7W+4LDx1qRcy1I04dKURQGmvkOxHnbbrSU+dhqhodo3avaJ0baTVv94E+BiZYs7Pd1h69D4zi2LDFjjzsMbTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVMJaX43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67002C4CEE4;
	Tue, 25 Mar 2025 11:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902416;
	bh=gUwSqRzMewDR6wgCqf6ynUzSFJs+WOdVR3q+skT2IAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZVMJaX436AR/M5cdbmYElEKrHYuEkthbFAu89QihCO/sYKEWT7mZaI/RoOz2olqrs
	 7HimdTXba8IFHPHHS8DqmgvKsLw5jAKud5LrmcK4cSjLnJTYtsf6xDw3Fv5hT6Us9/
	 wB86tERF0vC3JCUnB4CFHB8tVQ5/kwEddyeYCmBL+R3yrFS8XaTef7EhoMHiAY0d+4
	 OIGriWymSPsTgGKwDGYUs0oJjsIeoM7SM5xody4U/l3x97MDJKLznE9vaz1J1eSxQE
	 WGBuh6Ihtw39LgKPJB27n7jw4soBYuT5Vk2VkEGS+nYNR2Hk6uenBugR+Po0yxO6OY
	 xR2lupLiJ1TcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE
Date: Tue, 25 Mar 2025 07:33:35 -0400
Message-Id: <20250324233344-967a425cf23be182@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250324074129.1066447-1-bin.lan.cn@windriver.com>
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

Note: The patch differs from the upstream commit:
---
1:  b25e11f978b63 ! 1:  5094cffc5d0c1 Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE
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
| stable/linux-5.15.y       |  Success    |  Success   |

