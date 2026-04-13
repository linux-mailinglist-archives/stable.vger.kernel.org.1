Return-Path: <stable+bounces-236654-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKppId8g3WndaAkAu9opvQ
	(envelope-from <stable+bounces-236654-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:59:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E87173F06B7
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB881326C59B
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB1E2FFFBE;
	Mon, 13 Apr 2026 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ISmHHpGS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F16E28505E;
	Mon, 13 Apr 2026 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097461; cv=none; b=NU8ZXwMv3a042BtjMhNiKmDZ96Re+Su5YculAmlTz5M/FKZf7zCWpuKbuLbz0D5FW7zI/q02UZDbXP4lL88mQjTS88uImwrdx1lJ68ZUrEHYeCMN9Bzv+wGk+yHje72NbuVSUnMjoDVmT6cQASBXhwebahAqmxCiUVKl6NLNyEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097461; c=relaxed/simple;
	bh=acvar/reN8CNEgsd6R36m8cmGFXFI/i5/6+pt78Dx10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dVCeEN1hebpii1X5D6J/Rxbq5KPl6Dop3CFB6IJcoPQnTw3loh0v46pgLDIH1LJOLefUuVviw3Ae5sOiaq7pNOFDDzi50Ia+3iHJntGcepHUbP4hmHxK4C6/iId1QLNsmquG4SFbPNid5du3znIICNIyyASe0R9uRxdv4MzDETw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ISmHHpGS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85FAC2BCAF;
	Mon, 13 Apr 2026 16:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097461;
	bh=acvar/reN8CNEgsd6R36m8cmGFXFI/i5/6+pt78Dx10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ISmHHpGSmkUrJUgVBsVIhQYhxcKJ4DboYUR6S/RKlTUvgmfwx2HsJuL//wR9vIrZA
	 5djJV1Lr+dY+KtZqhqzw4KpwDfYD7nkLYwXvM6QK5YA4yXUqmJL2lWCbftUfcl4u8U
	 xYMnXuE8kjqHESh1dDgUNoGDR1cekFsfU0BC2rlg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oliver Neukum <oneukum@suse.com>,
	stable <stable@kernel.org>
Subject: [PATCH 5.15 145/570] usb: mdc800: handle signal and read racing
Date: Mon, 13 Apr 2026 17:54:36 +0200
Message-ID: <20260413155835.875040984@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236654-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E87173F06B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit 2d6d260e9a3576256fe9ef6d1f7930c9ec348723 upstream.

If a signal arrives after a read has partially completed,
we need to return the number of bytes read. -EINTR is correct
only if that number is zero.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Cc: stable <stable@kernel.org>
Link: https://patch.msgid.link/20260209142048.1503791-1-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/image/mdc800.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/image/mdc800.c
+++ b/drivers/usb/image/mdc800.c
@@ -708,7 +708,7 @@ static ssize_t mdc800_device_read (struc
 		if (signal_pending (current)) 
 		{
 			mutex_unlock(&mdc800->io_lock);
-			return -EINTR;
+			return len == left ? -EINTR : len-left;
 		}
 
 		sts=left > (mdc800->out_count-mdc800->out_ptr)?mdc800->out_count-mdc800->out_ptr:left;



