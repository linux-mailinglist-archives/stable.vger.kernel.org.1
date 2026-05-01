Return-Path: <stable+bounces-242260-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKsdKCh69GmLBgIAu9opvQ
	(envelope-from <stable+bounces-242260-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 12:02:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 083EC4AB7D1
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 12:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E7793022687
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 09:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2230F37E2F6;
	Fri,  1 May 2026 09:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="kn+SB0JY"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D992239E76;
	Fri,  1 May 2026 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777629559; cv=none; b=bnSQRxGv3febnw3OWHtHQI8t7SaY9fAWhNlsR36ioeO7JlZ5loE06wlzq1gbBkOy8NxAvq5TJ69wEvjUwQIwIszXg7Ekd34xb85AqUqN3lT3glzzxzG7j9QIOmY0wUITIYUMPTbKxmjWPho2JHsMG3VtiLodKBuX3Pr22svsKV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777629559; c=relaxed/simple;
	bh=Ht1Z3AXesOuPDUPc68E58Er9GLEBiH8LQ/rtm1UWLW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ws3oy4aBFSYQbItlpk6yaosyLkwnrDGnuy7VNnGSfJ8t+HlNv9rUO+LumRLEH8NAJ/2nU9S6ks6u6b4kn16yc+B4wEiVQPhp+Ss3GuRG8GW8a0StTDzVUV9BEbVQ2kc0joIZh8msNG5iLv+avH3x+b9qRfwYc55bj/UucgAyoPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=kn+SB0JY; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=Do0+DvOjHI9jdfhPM/JNVzuWC0QX+D3vjQ5ws8ibw3o=; b=kn+SB0JYTGW5ig/0BzSnWAExxU
	tgn9aDH8Ze5e7S91XqUqBY3FdSzc9LN2SXPC89LSD6hCVheGn+ft7XDjbGt3XBvy/NZffgO+iDjLW
	3DGmK6yt7Fcww3LNv4gECuDdI1tho/mZKGyoUXCOBa2I9CxVHAAzB6DZYZ32gNY6gWXjInPDre3Im
	nizrjQ5IAFA7TsvoC5TgkDCnH1arMlaQBPSCoB8CsjoSw7Bav74/SFiA91Ha+OmTQjUvbxarqgdEb
	I/mUBgoBAAqQNqMoAeWPmWo3ktf24MY4fk1RAlR0Kk0a/r8SmcZ7tmNaSbphP8Quds8RzG80RFZG8
	B1kI3sVg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wIkeH-008UfD-2G;
	Fri, 01 May 2026 09:59:06 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 01 May 2026 02:58:41 -0700
Subject: [PATCH net] netpoll: pass buffer size to egress_dev() to avoid MAC
 truncation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-netpoll_snprintf_fix-v1-1-84b0566e6597@debian.org>
X-B4-Tracking: v=1; b=H4sIAFF59GkC/yXMTQqDMBAG0KsM39pAIlpsrlKK+DNpp8gYkrQI4
 t2l7fYt3o7MSTjD047EH8myKjy5ijA9B32wkRmeUNv6YlvrjHKJ67L0WWMSLaEPsplrOzZ2tk0
 XXIeKEBMH2X7tDcoF9z/m9/jiqXxDHMcJT8sSwH0AAAA=
X-Change-ID: 20260501-netpoll_snprintf_fix-95b40d048f18
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Uday Shankar <ushankar@purestorage.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, clm@meta.com, 
 kernel-team@meta.com, stable@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=4419; i=leitao@debian.org;
 h=from:subject:message-id; bh=Ht1Z3AXesOuPDUPc68E58Er9GLEBiH8LQ/rtm1UWLW4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp9HllnQja2imHnx+OEwGtxaShqQxoe5+dI4pzo
 4yjvV+OXPeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCafR5ZQAKCRA1o5Of/Hh3
 bcU6D/9PkQStRQorMuIfbwxmVw77MUB2MeRx2IiDRqaGA+jZgQySh+4YJE77+uPgDT2d7+SF0f7
 TrZQgOfmYd+tfR/xtwN9vpPMxo0FwZp6vi13NHYcYuH+WkE9AUU8Wm9M8q60syxImWr10saGiQb
 mfPZYhoI7es9BX6WNFux7ry4JldbduM7wneL5vW5B4ta6pV+s4h7FS2zywVr0FMoExQVoPvw+Ns
 MR46guVAPvSo+OChOFDSJGVrt/cm6rOUbPHByOzLwBJWpiRzTW3yjpAxmRVOM2nrN1xr9wvLV24
 jra3fTbMuOXsF/49oiShYXTKBdDlfBV6g+wKuHa1hPjqzRG715Sj4T7flTYjDmrcTpCIecDuHXo
 gBcAM/Kf9t2JEoOvDWfMgjnO/iYfShX+7Cn8mZCqBW/pCEYVW8yPF3nFZupU/WLVyC2GJw3fBW2
 TlRaI1nTGA/HtWqw24Vj1yx8uPx9UaEVPuua7Ybr7XpGYJ2HlCSwdr3CJHkUhhSmqrH40Bbj1o2
 VDXvGxQtVNlQaDt0+pMoltMvYUT1LnzpAgMKFVAO2SpMpFjnq9nZcU55czVDW0NCPIk6aRSoNEy
 kALji9hVEg+JPEltJzLXz6uiTY+XoqCg8XhZMujPMbYwS3MGZThW+M1yYoEKkUbdkaN9mRYdB/S
 dCXVMSEnIdMn7cQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 083EC4AB7D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242260-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

egress_dev() formats np->dev_mac via snprintf() but receives buf as
a bare char *, so it cannot derive the buffer size from the pointer. The
size argument was hardcoded to MAC_ADDR_STR_LEN (3 * ETH_ALEN - 1 = 17),
which is silly wrong in two ways:

 1) misleading kernel log output on the MAC-selected target path
    (np->dev_name[0] == '\0'); for example "aa:bb:cc:dd:ee:ff doesn't
    exist, aborting" was logged as "aa:bb:cc:dd:ee:f doesn't exist,
    aborting".

 2) the second argument of snprintf is the size of the buffer, not the
    size of what you want to write.

Add a bufsz parameter to egress_dev() and pass sizeof(buf) from each
caller, matching the standard snprintf() idiom and removing the
hardcoded size from the helper.

Every caller already declares "char buf[MAC_ADDR_STR_LEN + 1]" so the
formatted MAC continues to fit.

Tested by booting with
  netconsole=6665@/aa:bb:cc:dd:ee:ff,6666@10.0.0.1/00:11:22:33:44:55
on a kernel without a matching device. Pre-fix dmesg shows
"aa:bb:cc:dd:ee:f doesn't exist, aborting"; post-fix shows the full
"aa:bb:cc:dd:ee:ff doesn't exist, aborting".

Fixes: f8a10bed32f5 ("netconsole: allow selection of egress interface via MAC address")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/netpoll.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 4381e0fc25bf4..84faace50ac28 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -608,14 +608,16 @@ EXPORT_SYMBOL_GPL(__netpoll_setup);
 /*
  * Returns a pointer to a string representation of the identifier used
  * to select the egress interface for the given netpoll instance. buf
- * must be a buffer of length at least MAC_ADDR_STR_LEN + 1.
+ * is used to format np->dev_mac when np->dev_name is empty; bufsz must
+ * be at least MAC_ADDR_STR_LEN + 1 to fit the formatted MAC address
+ * and its NUL terminator.
  */
-static char *egress_dev(struct netpoll *np, char *buf)
+static char *egress_dev(struct netpoll *np, char *buf, size_t bufsz)
 {
 	if (np->dev_name[0])
 		return np->dev_name;
 
-	snprintf(buf, MAC_ADDR_STR_LEN, "%pM", np->dev_mac);
+	snprintf(buf, bufsz, "%pM", np->dev_mac);
 	return buf;
 }
 
@@ -645,7 +647,7 @@ static int netpoll_take_ipv6(struct netpoll *np, struct net_device *ndev)
 
 	if (!IS_ENABLED(CONFIG_IPV6)) {
 		np_err(np, "IPv6 is not supported %s, aborting\n",
-		       egress_dev(np, buf));
+		       egress_dev(np, buf, sizeof(buf)));
 		return -EINVAL;
 	}
 
@@ -667,7 +669,7 @@ static int netpoll_take_ipv6(struct netpoll *np, struct net_device *ndev)
 	}
 	if (err) {
 		np_err(np, "no IPv6 address for %s, aborting\n",
-		       egress_dev(np, buf));
+		       egress_dev(np, buf, sizeof(buf)));
 		return err;
 	}
 
@@ -687,14 +689,14 @@ static int netpoll_take_ipv4(struct netpoll *np, struct net_device *ndev)
 	in_dev = __in_dev_get_rtnl(ndev);
 	if (!in_dev) {
 		np_err(np, "no IP address for %s, aborting\n",
-		       egress_dev(np, buf));
+		       egress_dev(np, buf, sizeof(buf)));
 		return -EDESTADDRREQ;
 	}
 
 	ifa = rtnl_dereference(in_dev->ifa_list);
 	if (!ifa) {
 		np_err(np, "no IP address for %s, aborting\n",
-		       egress_dev(np, buf));
+		       egress_dev(np, buf, sizeof(buf)));
 		return -EDESTADDRREQ;
 	}
 
@@ -736,7 +738,8 @@ int netpoll_setup(struct netpoll *np)
 		ndev = dev_getbyhwaddr(net, ARPHRD_ETHER, np->dev_mac);
 
 	if (!ndev) {
-		np_err(np, "%s doesn't exist, aborting\n", egress_dev(np, buf));
+		np_err(np, "%s doesn't exist, aborting\n",
+		       egress_dev(np, buf, sizeof(buf)));
 		err = -ENODEV;
 		goto unlock;
 	}
@@ -744,14 +747,14 @@ int netpoll_setup(struct netpoll *np)
 
 	if (netdev_master_upper_dev_get(ndev)) {
 		np_err(np, "%s is a slave device, aborting\n",
-		       egress_dev(np, buf));
+		       egress_dev(np, buf, sizeof(buf)));
 		err = -EBUSY;
 		goto put;
 	}
 
 	if (!netif_running(ndev)) {
 		np_info(np, "device %s not up yet, forcing it\n",
-			egress_dev(np, buf));
+			egress_dev(np, buf, sizeof(buf)));
 
 		err = dev_open(ndev, NULL);
 		if (err) {

---
base-commit: edf4bee4215a173c0534d1851d7523d827149f9e
change-id: 20260501-netpoll_snprintf_fix-95b40d048f18

Best regards,
--  
Breno Leitao <leitao@debian.org>


