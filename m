Return-Path: <stable+bounces-229557-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEpZIl57wWknTgQAu9opvQ
	(envelope-from <stable+bounces-229557-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:41:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D65E32FA3B4
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDEC13198E95
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D073B8BD5;
	Mon, 23 Mar 2026 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cu92xMkh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3D13B8D75;
	Mon, 23 Mar 2026 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282243; cv=none; b=eEPms9yybN7YKfOwLp9xt21PRXj7A3zZf3DmcUn1PwS5yCap0KP1KrASpCM33Gcg51QFcW+Pbf+D4kVhq0hw29UByu6PRLhKtZ1cFyjx+bhS1zCB5Q4k8RrAMpc2rbkOICy9wFG0giTS/DbxaCDMGzyZP/a13IVmX6zCd3bNMHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282243; c=relaxed/simple;
	bh=5T4cFJnaYDb5sAtrVOZzj+G32acNJDuI9qpKfeDv8Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zrjil73ApxTMOb9uajC1s6D8IZD8XUtyn37nKm5f2hL27V43lzYahRe06xMa+ApkS+RdGVBXs2asKqHq8olGki/8ekZeWSM5QvlgYhS2eHBT3MHmtH8Gak0qN4rjrN+RRctqlQz5gAURoIxnlDGJlUUJwavzujjb06sF8yaWpXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cu92xMkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FD3C4CEF7;
	Mon, 23 Mar 2026 16:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282243;
	bh=5T4cFJnaYDb5sAtrVOZzj+G32acNJDuI9qpKfeDv8Hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cu92xMkh0edvDEV6kjdPvoiGmNG5HRI/swd0cZkNk15ZPFTgeYht0NAAFQGPO8+d/
	 V4umjpHOCxOeH/ornNNRzDw1uh8BzT533VdHCAAYGBm8pESdkRZ+0pfIlPYyY2uSMd
	 dDg/ZH9b037hfyabUH35dF2YliZ4HOMPnRwGnTyI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+b09c1af8764c0097bb19@syzkaller.appspotmail.com,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.1 083/481] wifi: radiotap: reject radiotap with unknown bits
Date: Mon, 23 Mar 2026 14:41:05 +0100
Message-ID: <20260323134527.285769656@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-229557-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,b09c1af8764c0097bb19];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url]
X-Rspamd-Queue-Id: D65E32FA3B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

commit c854758abe0b8d86f9c43dc060ff56a0ee5b31e0 upstream.

The radiotap parser is currently only used with the radiotap
namespace (not with vendor namespaces), but if the undefined
field 18 is used, the alignment/size is unknown as well. In
this case, iterator->_next_ns_data isn't initialized (it's
only set for skipping vendor namespaces), and syzbot points
out that we later compare against this uninitialized value.

Fix this by moving the rejection of unknown radiotap fields
down to after the in-namespace lookup, so it will really use
iterator->_next_ns_data only for vendor namespaces, even in
case undefined fields are present.

Cc: stable@vger.kernel.org
Fixes: 33e5a2f776e3 ("wireless: update radiotap parser")
Reported-by: syzbot+b09c1af8764c0097bb19@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/69944a91.a70a0220.2c38d7.00fc.GAE@google.com
Link: https://patch.msgid.link/20260217120526.162647-2-johannes@sipsolutions.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/radiotap.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/wireless/radiotap.c
+++ b/net/wireless/radiotap.c
@@ -239,14 +239,14 @@ int ieee80211_radiotap_iterator_next(
 		default:
 			if (!iterator->current_namespace ||
 			    iterator->_arg_index >= iterator->current_namespace->n_bits) {
-				if (iterator->current_namespace == &radiotap_ns)
-					return -ENOENT;
 				align = 0;
 			} else {
 				align = iterator->current_namespace->align_size[iterator->_arg_index].align;
 				size = iterator->current_namespace->align_size[iterator->_arg_index].size;
 			}
 			if (!align) {
+				if (iterator->current_namespace == &radiotap_ns)
+					return -ENOENT;
 				/* skip all subsequent data */
 				iterator->_arg = iterator->_next_ns_data;
 				/* give up on this namespace */



