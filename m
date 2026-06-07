Return-Path: <stable+bounces-261149-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r2a7AT5HJWpZFwIAu9opvQ
	(envelope-from <stable+bounces-261149-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:26:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 566A164FA6F
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:26:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=V4b8tE17;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261149-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261149-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2ABF330571A2
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5102DB7A3;
	Sun,  7 Jun 2026 10:17:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307034071DA;
	Sun,  7 Jun 2026 10:17:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827428; cv=none; b=fLIwVNzUNQKlVgXxFMOnyD1Jt+pLgExpEvWcOqc1gB52Er6I7wCy4dvBaKY7BN0j/v7JgnokB48+a9u5vqKoo2VyngV8Ew17pgBUss3sJ36QysVxlEme2dAFb35Z70IeY+6KgL+JtUCVj0eez10n8XUR4AqMGv+8yh5mv2POJGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827428; c=relaxed/simple;
	bh=GC4LylfI4ZepBXredcUa1GNDMQp7FhMeyyYomBYpfsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOg1+qWVK1TkCGeHvC75WSWxB5TspSxzbysWisH7fn70WWP1d83D6a1esdG0bsObmB/I7htsxNNBl8hmBaHVNuu9+IHFAYTQxOsiRtBV8mxHnEW6cLRJ16qO9DAffkLRf3fYwd/LM11q3Pw7sDqoh32vekemRXhfZX6ycpOUwsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V4b8tE17; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371491F00893;
	Sun,  7 Jun 2026 10:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827427;
	bh=avqjTqABi3zGFyXY8t8zZEfwFw3c9a0vkMXMB/Owu7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V4b8tE17mPbbBx3J4Kw40aL7rnAvjF2Pppos4C8zJSUFkZIII6ezCtXIkdyDY3+zV
	 mVk7Ae1oISmsOgx0YhrQuv3MR3wW9BwLsLixfgB2y92l6xx3HIA78onn/ZGyx/ZrMK
	 mRPc3JHdpYaX9lVBrDWzcAAuhBT9sW2idvQAh5Uc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 092/332] net/handshake: Drain pending requests at net namespace exit
Date: Sun,  7 Jun 2026 11:57:41 +0200
Message-ID: <20260607095731.531288373@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261149-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:chuck.lever@oracle.com,m:hare@kernel.org,m:pabeni@redhat.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 566A164FA6F

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit ea5fe6a73ca57e5150b8a38b341aef2636eb72f0 ]

The arguments to list_splice_init() in handshake_net_exit() are
reversed. The call moves the local empty "requests" list onto
hn->hn_requests, leaving the local list empty, so the subsequent
drain loop runs zero iterations. Pending handshake requests that
had not yet been accepted are not torn down when the net namespace
is destroyed; each one keeps a reference on a socket file and on
the handshake_req allocation.

Pass the source and destination in the documented order
(list_splice_init(list, head) moves list onto head) so the pending
list is transferred to the local scratch list and drained through
handshake_complete().

Fixing the splice direction exposes a list-corruption race. After
the splice each req->hr_list still has non-empty link pointers,
threading the stack-local scratch list rather than hn_requests.
A concurrent handshake_req_cancel() -- for example, from sunrpc's
TLS timeout on a kernel socket whose netns reference was not
taken -- finds the request through the rhashtable, calls
remove_pending(), and sees !list_empty(&req->hr_list).
__remove_pending_locked() then list_del_init()s an entry off the
scratch list while the drain iterates, corrupting it. The same
call arriving after the drain loop has run list_del() on an
entry hits LIST_POISON instead.

Have remove_pending() check HANDSHAKE_F_NET_DRAINING under
hn_lock and report not-found when drain is in progress. The
drain has already taken ownership; handshake_complete()'s existing
test_and_set on HANDSHAKE_F_REQ_COMPLETED still arbitrates
between drain and cancel for who calls the consumer's hp_done. Use
list_del_init() rather than list_del() in the drain so req->hr_list
does not carry LIST_POISON after drain releases the entry.

The DRAINING guard in remove_pending() makes cancel return false,
but cancel still falls through to test_and_set_bit on
HANDSHAKE_F_REQ_COMPLETED and drops the request's hr_file reference.
Without another pin, if that is the last reference, sk_destruct frees
the request while it is still linked on the drain loop's local list.
Pin each request's hr_file under hn_lock before releasing the list,
and drop that drain pin after the loop finishes with the request.

Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Link: https://patch.msgid.link/20260525-handshake-file-pin-v3-8-66c616906ead@oracle.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/handshake/netlink.c | 10 ++++++++--
 net/handshake/request.c |  5 ++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index 21d6cbd52fcdb6..3fd4fef9bab1a4 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -201,13 +201,19 @@ static void __net_exit handshake_net_exit(struct net *net)
 	 */
 	spin_lock_bh(&hn->hn_lock);
 	set_bit(HANDSHAKE_F_NET_DRAINING, &hn->hn_flags);
-	list_splice_init(&requests, &hn->hn_requests);
+	list_splice_init(&hn->hn_requests, &requests);
+	list_for_each_entry(req, &requests, hr_list)
+		get_file(req->hr_file);
 	spin_unlock_bh(&hn->hn_lock);
 
 	while (!list_empty(&requests)) {
+		struct file *file;
+
 		req = list_first_entry(&requests, struct handshake_req, hr_list);
-		list_del(&req->hr_list);
+		file = req->hr_file;
+		list_del_init(&req->hr_list);
 		handshake_complete(req, -ETIMEDOUT, NULL);
+		fput(file);
 	}
 }
 
diff --git a/net/handshake/request.c b/net/handshake/request.c
index e2d7ee7ce6e0e0..2f1ab6eb9538c5 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -163,13 +163,16 @@ static void __remove_pending_locked(struct handshake_net *hn,
  * otherwise %false.
  *
  * If @req was on a pending list, it has not yet been accepted.
+ * Returns %false when the net namespace is draining; the drain
+ * loop has taken ownership of the pending list.
  */
 static bool remove_pending(struct handshake_net *hn, struct handshake_req *req)
 {
 	bool ret = false;
 
 	spin_lock_bh(&hn->hn_lock);
-	if (!list_empty(&req->hr_list)) {
+	if (!test_bit(HANDSHAKE_F_NET_DRAINING, &hn->hn_flags) &&
+	    !list_empty(&req->hr_list)) {
 		__remove_pending_locked(hn, req);
 		ret = true;
 	}
-- 
2.53.0




