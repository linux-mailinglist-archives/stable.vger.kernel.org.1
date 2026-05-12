Return-Path: <stable+bounces-246394-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGsjDb9yA2q55wEAu9opvQ
	(envelope-from <stable+bounces-246394-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:34:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ECB527CC3
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6D3531B4372
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9111F2D060B;
	Tue, 12 May 2026 18:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qAByitK4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C50D1DED4C;
	Tue, 12 May 2026 18:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609113; cv=none; b=nH1K3yIZ4nRxeb5Ru07EFlnarEFbDixvHdI0gKRzkdrJ+gSG8sJGr+D+jsV0e2F8PgBTQRzP4c//dPEKhkqtbFgL0T1YZO4R1DOWqm1HrfoNqPX9z1nc9WpMgPYavYTpNcwMcdzZYUMJ1Ps7TVTtotswQ7DH3geuSYygolxVKPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609113; c=relaxed/simple;
	bh=cvmABmWvMVw5vzwqtE8ekx2Q+GjjnlffxnPKl8O0XKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fG8knrtg3X+stsBdxfeX7OzeU9bdSio2jovwPX/U6Dcz/8ml8KLtpWJ+7ol3Q2gx338dsXRtilx2tSkD6lUTcRRlFCREuQ1wuZ8k3ouz0O3kV63x6Bozsoqhq0jX+uXsnqTPfZmKoeWH/a2gke8Abx5H0PUmYzqry4TrpfssmoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qAByitK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90981C2BCB0;
	Tue, 12 May 2026 18:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609112;
	bh=cvmABmWvMVw5vzwqtE8ekx2Q+GjjnlffxnPKl8O0XKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qAByitK4cFMBw+SP3DSiqomQfRzVtdmg91m5lObKaWvPTWc0+7pT82UrKMhwEHQDv
	 F1jZMubtQwewzNmimx0vsBXuR1146mPED8VKu6upUppFrv4j0TVMGwwlybKaCeQ2PB
	 jEB5fsrf6Xy+fjj+E95msimIdWeP9+fUrilUv+JQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+5de83f57cd8531f55596@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 7.0 028/307] wifi: rsi: fix kthread lifetime race between self-exit and external-stop
Date: Tue, 12 May 2026 19:37:03 +0200
Message-ID: <20260512173940.719652884@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 88ECB527CC3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-246394-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,syzkaller.appspotmail.com,gmail.com,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,5de83f57cd8531f55596];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,intel.com:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeongjun Park <aha310510@gmail.com>

commit db57a1aa54ff68669781976e4edb045e09e2b65b upstream.

RSI driver use both self-exit(kthread_complete_and_exit) and external-stop
(kthread_stop) when killing a kthread. Generally, kthread_stop() is called
first, and in this case, no particular issues occur.

However, in rare instances where kthread_complete_and_exit() is called
first and then kthread_stop() is called, a UAF occurs because the kthread
object, which has already exited and been freed, is accessed again.

Therefore, to prevent this with minimal modification, you must remove
kthread_stop() and change the code to wait until the self-exit operation
is completed.

Cc: <stable@vger.kernel.org>
Reported-by: syzbot+5de83f57cd8531f55596@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69e5d03b.a00a0220.1bd0ca.0064.GAE@google.com/
Fixes: 4c62764d0fc2 ("rsi: improve kernel thread handling to fix kernel panic")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
Link: https://patch.msgid.link/20260422173846.37640-1-aha310510@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/rsi/rsi_common.h |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/net/wireless/rsi/rsi_common.h
+++ b/drivers/net/wireless/rsi/rsi_common.h
@@ -70,12 +70,11 @@ static inline int rsi_create_kthread(str
 	return 0;
 }
 
-static inline int rsi_kill_thread(struct rsi_thread *handle)
+static inline void rsi_kill_thread(struct rsi_thread *handle)
 {
 	atomic_inc(&handle->thread_done);
 	rsi_set_event(&handle->event);
-
-	return kthread_stop(handle->task);
+	wait_for_completion(&handle->completion);
 }
 
 void rsi_mac80211_detach(struct rsi_hw *hw);



