Return-Path: <stable+bounces-213539-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIuMFFZdg2mJlQMAu9opvQ
	(envelope-from <stable+bounces-213539-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:53:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE936E783F
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05DBA3025E70
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3F541325F;
	Wed,  4 Feb 2026 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pa71ureN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07B73AEF30;
	Wed,  4 Feb 2026 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216671; cv=none; b=H1cjVwu991JQ/1jaZKJ5i7J0I6JPk4Fq7xj+TEvytjrmXqWD+0JgkffeA3i/Gy0PL4s2+xq3FfZIEByE6Q7wzByonDvkXWsG285kkpp04ABlgzlDzHQc0Ukf/fwx7kmPPWLzWUW78Q9B65kAEfg7JD4KMBBklkHu+x16+5+kzyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216671; c=relaxed/simple;
	bh=MLtv9w73XCv5wjFqzSEdYTj9nI1T7tM4UJn4PbpzS+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ip9eJ+4SLAzWzFSGPQjQUzqwj4UVynIPj0HnLqa1gwlzAoI0qdszQPcRWDeBhh3N0XFW2HjVhmayOCUlf2nWiQpBDli5SftCHb43DLOWPZySZTwuFkxY+sYiOcSyMtDS340BuzOS3JaYw+SMxSd1ZTpU9QJFVKFajLNmkrldbVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pa71ureN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DEEC4CEF7;
	Wed,  4 Feb 2026 14:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216671;
	bh=MLtv9w73XCv5wjFqzSEdYTj9nI1T7tM4UJn4PbpzS+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pa71ureNA4ZFsmpqTGEWBa/k6WdsrOlmQ+Qi4wktDLhYMT2napMyratFfzAJCbZwq
	 mIJbLBVhugq3lOB+5CJVwJbOC67Sb7K4yy+frTISD8gMN75O5HITFctkrmdgJSL/2e
	 1F93ddnCjpDH7239ny4VV8qVPM6ijUtnmlyXZQTc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Henry Martin <bsdhenrymartin@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 5.10 158/161] HID: uclogic: Add NULL check in uclogic_input_configured()
Date: Wed,  4 Feb 2026 15:40:21 +0100
Message-ID: <20260204143857.433415105@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.755002596@linuxfoundation.org>
References: <20260204143851.755002596@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213539-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.com,163.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE936E783F
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Henry Martin <bsdhenrymartin@gmail.com>

[ Upstream commit bd07f751208ba190f9b0db5e5b7f35d5bb4a8a1e ]

devm_kasprintf() returns NULL when memory allocation fails. Currently,
uclogic_input_configured() does not check for this case, which results
in a NULL pointer dereference.

Add NULL check after devm_kasprintf() to prevent this issue.

Fixes: dd613a4e45f8 ("HID: uclogic: Correct devm device reference for hidinput input_dev name")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
[ Adjust context ]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-uclogic-core.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -143,9 +143,12 @@ static int uclogic_input_configured(stru
 		break;
 	}
 
-	if (suffix)
+	if (suffix) {
 		hi->input->name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
 						 "%s %s", hdev->name, suffix);
+		if (!hi->input->name)
+			return -ENOMEM;
+	}
 
 	return 0;
 }



