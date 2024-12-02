Return-Path: <stable+bounces-96051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9B49E04EB
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED6F168E22
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3049B2040BE;
	Mon,  2 Dec 2024 14:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQgX8PY9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E0A204080
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149609; cv=none; b=oA2tUJq7u9JYNgQ5QQYjAtNK66g/OE+wtX7wYxLJ4zyYaa50/54nYN3KL3Z1nD05yabByMbVJID1F9hZgzO8WPnoSSvYiO7uKgkVoozCD7CCZIQB1ABtHRw86T5CeEgU82n3/zC44qulal7PMhWfaqNn4UdygrH/yg7cPQocSAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149609; c=relaxed/simple;
	bh=W2HrwpOnN2X5Zp9zqkjB+2f1iF/lVXRHG+CQ0DVUHOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3L6qZohkSOQWVvpfJ37jIRCm/horMfr+SgtTyRGALSp66FbRjR5hDeyn9YQfZrRu7u7Mox/weUykOYJkmiGYHJ/qWtbDwpspCbhlpx3W12HRrCPpJ6w9CMR5/iHUlT2T6CiltreEktz+ZGjRY4deMAb5We3hqvjA5ji9rYOWlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQgX8PY9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1085AC4CED1;
	Mon,  2 Dec 2024 14:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733149608;
	bh=W2HrwpOnN2X5Zp9zqkjB+2f1iF/lVXRHG+CQ0DVUHOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jQgX8PY9r4e44/uBPSMEMBfcoJkyQaYkB6yrnCWjkOIdnSAg0d2tB2p63lOusTDID
	 aTz5Nh0jAEBW8U9D0xpLuLutEvoYSmqlMNW9YyT0xYWYWwVtteEh/lq6Ofwqob5ZjS
	 ipGOuJv/Sl3IF384Fb5ofsa6j5phmb+5UozrNOUq6GfVVXkpagL0wHMhdZUZ9Ppryg
	 NGE8zPpSSvwP+9yHRum6vgy7L8Uk2dyMDOGQmSliSXXYepTWU7LFZ9i2C6w8/tPmb+
	 9q+kLdua4ZF2pwmop9jkXlw6kXpMZjVHjB30u395fX8lm/pehZVKvn8X373JN9fXHU
	 w/Uyt8UBlfMfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH net] net: usb: usbnet: fix name regression
Date: Mon,  2 Dec 2024 09:26:46 -0500
Message-ID: <20241202074609-f4769fda1c09a8da@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241017071849.389636-1-oneukum@suse.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: 8a7d12d674ac6f2147c18f36d1e15f1a48060edf


Status in newer kernel trees:
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Failed     |  N/A       |
| stable/linux-6.11.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |
| stable/linux-4.19.y       |  Failed     |  N/A       |

