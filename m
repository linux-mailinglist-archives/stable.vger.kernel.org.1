Return-Path: <stable+bounces-167129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11D5B22507
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 12:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99022A0AC8
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 10:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC58B2EBDC8;
	Tue, 12 Aug 2025 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naj3MazF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC122E92CD
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995925; cv=none; b=WflC7he5QqwKLh9WVhJxxVQEBW4+y5+Woai6qQNxaJFOT5af1oRexNSInwHsmaBYaeLIiw6pYTT/PCHGuHWFm/R4e3YkHH4GyGmEIP+Yp1hfcUEZhIlGXgnc9s/x9elgutq9YN5nWAbh/Y4HQ1UbntGkDp70fGEJ/j17q3Jucqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995925; c=relaxed/simple;
	bh=ECvkgOpY5BTpu5tq5gVjeuv455n2Yj6td1RkmUNqDe0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Prq7TgrEpBTXWOEsNKNcb43j+I7K/mq9ZNztxjtTTSiHpyiT3m3QYAwEwzgDPoosV4jKOdQwPhkYm6V8YFlndEaCByCXdzYSkOhRVkMLcTU2Yb5X6yfWVDUIDKBQMVj9Mpz4hx9jKn8ET6pqtgdNmDGrhF6pGV+e4fXzydMVk+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naj3MazF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A347CC4CEF0;
	Tue, 12 Aug 2025 10:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754995925;
	bh=ECvkgOpY5BTpu5tq5gVjeuv455n2Yj6td1RkmUNqDe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=naj3MazFpU0IIk8IHb7Q06+yDfgxN3O2mFCEE5v6gpuzfe8mAaewNTPU9BhP33Gab
	 yK82WuS2pt2QrYu33kXCWJTmDYfvH5lNYTxIYP3QR95Rd3AmoUgmqErgBvn1m06fkX
	 J2CLmxLXH2ikJ4fNdbEj+JziXJw8QIdJKfh/LpSSIM7rnN9pnN80Yg3vR7HMNQm3vb
	 k8doVzYUZvhBfmXNO233z6J0tbY4m1pf8m4VWfVOJaiopRk1WT7BqHTAtpHwsnef3N
	 u402GJHuzbQRSrOnV31y+Idbrj4bACVLQgYlP7yC3/1Sl+0/KcKIuUW6+6diInoV0C
	 YYvZv3NctLWkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync
Date: Tue, 12 Aug 2025 00:12:22 -0400
Message-Id: <1754966493-e7374263@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250812013457.425332-1-sumanth.gavini@yahoo.com>
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

The upstream commit SHA1 provided is correct: 5af1f84ed13a416297ab9ced7537f4d5ae7f329a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Sumanth Gavini <sumanth.gavini@yahoo.com>
Commit author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  5af1f84ed13a ! 1:  347ef4c82277 Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync
    @@
      ## Metadata ##
    -Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    +Author: Sumanth Gavini <sumanth.gavini@yahoo.com>
     
      ## Commit message ##
         Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync
     
    +    commit 5af1f84ed13a416297ab9ced7537f4d5ae7f329a upstream.
    +
         Connections may be cleanup while waiting for the commands to complete so
         this attempts to check if the connection handle remains valid in case of
         errors that would lead to call hci_conn_failed:
    @@ Commit message
          hci_abort_conn_sync+0x237/0x360
     
         Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    +    Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>
     
      ## net/bluetooth/hci_sync.c ##
     @@ net/bluetooth/hci_sync.c: static int hci_reject_conn_sync(struct hci_dev *hdev, struct hci_conn *conn,
    @@ net/bluetooth/hci_sync.c: static int hci_reject_conn_sync(struct hci_dev *hdev,
     +		err = hci_disconnect_sync(hdev, conn, reason);
     +		break;
      	case BT_CONNECT:
    - 		err = hci_connect_cancel_sync(hdev, conn, reason);
    + 		err = hci_connect_cancel_sync(hdev, conn);
     -		/* Cleanup hci_conn object if it cannot be cancelled as it
    --		 * likelly means the controller and host stack are out of sync
    --		 * or in case of LE it was still scanning so it can be cleanup
    --		 * safely.
    +-		 * likelly means the controller and host stack are out of sync.
     -		 */
     -		if (err) {
     -			hci_dev_lock(hdev);
    @@ net/bluetooth/hci_sync.c: static int hci_reject_conn_sync(struct hci_dev *hdev,
     -		return hci_reject_conn_sync(hdev, conn, reason);
     +		err = hci_reject_conn_sync(hdev, conn, reason);
     +		break;
    - 	case BT_OPEN:
    - 	case BT_BOUND:
    - 		hci_dev_lock(hdev);
    -@@ net/bluetooth/hci_sync.c: int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
    - 		return 0;
      	default:
      		conn->state = BT_CLOSED;
     -		break;

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-6.1.y        | Success     | Success    |

