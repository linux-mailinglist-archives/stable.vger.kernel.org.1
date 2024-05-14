Return-Path: <stable+bounces-43995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E339F8C50B2
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E45EB20A8C
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5002113E8AF;
	Tue, 14 May 2024 10:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FLJAu/OK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F1413E8A5;
	Tue, 14 May 2024 10:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683587; cv=none; b=AHo5GY++8swCVIIalmJNvxMChbuFqPyFoslOdCVKn7FrhxmAEqMhSKP0W7UnYAozGafe1KGC64S6wWiEo/3SwWmAwyaLE3daE3BRzbiiTIxe/jt52T53HmtS/hQND9RcccBVkEBhDLXkZ0eyJW8mMSdFVY+P5wopHZwBRjZNjwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683587; c=relaxed/simple;
	bh=GpLGX9kVoP0ZTbXVl8i6ai9lK9IYxSquGk+Mof7L+W8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwj1iq58XC7mnB6CWD0THbwvlvJQlk6twAnJwhvqBsgGT02OknQN4FXZjrq5x8MHMFrdQqL3fmnsLw7dpTnArRrUjFJttBilEQqR/IjtEgzSk0+iuzc87ZJZ9Ir+ONsD4P5ejZHLQHuXXSY7x50xSEdpb8MWqrxmb6a3Tca/pq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FLJAu/OK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A07C2BD10;
	Tue, 14 May 2024 10:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715683586;
	bh=GpLGX9kVoP0ZTbXVl8i6ai9lK9IYxSquGk+Mof7L+W8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FLJAu/OKG3AUpap9NYSatw4dmCr/qOgs7wxMWBCIC2kTxGl2bDE1UNlsLlw2FRBzS
	 jkz3XEQjAtSJ+K3f+dCj9zkAP5EZcoJnFZLob8P1uvpYUCPwGOy4aRPdM2B6SWEbm3
	 Y0ye/GwTx71tM60kmk3UnouC7F1St4EOU7JSyCbM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzbot+0438378d6f157baae1a2@syzkaller.appspotmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 212/336] nfc: nci: Fix kcov check in nci_rx_work()
Date: Tue, 14 May 2024 12:16:56 +0200
Message-ID: <20240514101046.616317911@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit 19e35f24750ddf860c51e51c68cf07ea181b4881 ]

Commit 7e8cdc97148c ("nfc: Add KCOV annotations") added
kcov_remote_start_common()/kcov_remote_stop() pair into nci_rx_work(),
with an assumption that kcov_remote_stop() is called upon continue of
the for loop. But commit d24b03535e5e ("nfc: nci: Fix uninit-value in
nci_dev_up and nci_ntf_packet") forgot to call kcov_remote_stop() before
break of the for loop.

Reported-by: syzbot <syzbot+0438378d6f157baae1a2@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=0438378d6f157baae1a2
Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/6d10f829-5a0c-405a-b39a-d7266f3a1a0b@I-love.SAKURA.ne.jp
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/nfc/nci/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 0d26c8ec9993e..b133dc55304ce 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1518,6 +1518,7 @@ static void nci_rx_work(struct work_struct *work)
 
 		if (!nci_plen(skb->data)) {
 			kfree_skb(skb);
+			kcov_remote_stop();
 			break;
 		}
 
-- 
2.43.0




