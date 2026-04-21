Return-Path: <stable+bounces-240069-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGEJBk8p52mo4wEAu9opvQ
	(envelope-from <stable+bounces-240069-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:37:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6E4437B36
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A05F230055B2
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 07:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656613822AE;
	Tue, 21 Apr 2026 07:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="bXduOs3p"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763F2331A78;
	Tue, 21 Apr 2026 07:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776757066; cv=none; b=UwyNEapbbMqoz7GLwyuPvbaa7DVIoVmKiMeRsYPYLr6V+e+Ut8s2PIg9YUAkcNsg9zTOZ+KuT9JIaNrK7L1LFlbzqTKVUB6RqINtHBllut72f/i++Oc41XsbzXQjqjoz6kdt4sKRJWI3Zsmapui23AOE/XsZPQAZ072IcQc5vxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776757066; c=relaxed/simple;
	bh=SZcklxgbjsX5ROMo/zD0+7P0xxMaGcOIVethWe0eTFs=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=SVjLvBwZGiIhEKv+WqbhVRpZXPEUAJbFmXE2hn16bglqH23ioruHEVsWEAxGIAsAt3NQBdcafh9AfA482aZ+oqTF8SnXO057uIDURsi5BZfhPVLUnpHs+xO0MKsT+fJplxlr2wkKyR65sT/ewVflMmWnICT5L8SwRPwxdkhJU9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=bXduOs3p; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1776757053;
	bh=2BBidtQmGzyXD/iwQeUorAjjDt5+eczMlZJZiK5y47c=;
	h=From:To:Cc:Subject:Date;
	b=bXduOs3pnI4YZBLFrqcm4AI041rmihVF05/4sE+aVLBNg2GTX8be7PHk1eyFuXqYV
	 nkNqw/3+7CZahOxCKH/KwFLbS9e8b4USSPZtdnRuMspl+ziW4wxkkHJCoWApbh43xB
	 AVl1FS9l8ufHs8yC/3ZnFdGZsmvakdUrIhgHBx/c=
Received: from China-team ([183.241.55.34])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 93391298; Tue, 21 Apr 2026 15:36:51 +0800
X-QQ-mid: xmsmtpt1776757011tmk20dh89
Message-ID: <tencent_7584C190359CD12AD5987DB848D65BFFE10A@qq.com>
X-QQ-XMAILINFO: OR37DonC/00MCS5yXHp3/J333TXtMSiu4sUMVoulxmLaPnaZ+qLLlKiJasG2PD
	 Qo0QAT+YomW1B2LG9A9pKvYf2sxRjn4//1Thrpr86bbvpDzTFAk2Q5obkZodZoCO8zAdlcpmQekS
	 TxSmsHffYRpHw3caEjkD4P8J1xXMAlclFBbUuBzDC8CiS6lZauwEEEiKDZS540iaQM7hIrSN+e/G
	 pWd5AVA/FnVIAaiQMUbGoAYdXU5mMQ2ZtT49U5Nzf90BtptrrtcM8sBEZsftSJVb2PCixDnzX0yK
	 r3ReoODyuRwMk6lB+ZPB3u+WIOId8JXZ4/zb9xCjFygJuPmf/Hnkjsfi4upVThOP5s+CAxFLg/Sf
	 vsofBNDt/VKMbCosuJdJD6stSmyqLODX8Yi5xqcRXSQECwNoyz9vuJuhiuQnB5GMuORSDldxtSi3
	 1S+JZawexCJr0PHs/0Q7Wny2V3LCvXhZmrspSVDUdwXDN/jXbeYz/I3Dh3j1o0jKKjuHcyt3edWk
	 kK5nHota+T1AVxvTLw+5fUDpqcjKnTeCUcwb8HWA9d1cfvZXFJiZgH/aXtMQDpLOtUfIguAn+jgG
	 r16KaiJ9o1g1E+rxRzlpt8Ssg/DUh6IZaUaEIuSYPpRDcdNqGuShbD0GVsZzRIrdodTzPulQQPjo
	 R5yU1eu6OIfhTUT50kob8ofVl0lOZNg8TiYp96VfQKp4rGn/GLXUSYtad3jxJsWAtBpdM8xn1KpA
	 8+iPMI51vvYW0yDhUwcr50GRnVrOQfJ4xMgP57wFiaPJDw+c7p/1RsUCrstRLoHG2mmBirqqlGsd
	 L7sdCb4xFsThghJ73gJyS6qN6Ae4s2Qp8NU70kNhElyLf8KRVrIleF+fOORHY/+avdXbcY4+HIIJ
	 PV6XFk9FkkVsKaz8LrwJ/SOpsGe6yEz3f+oXuYSOygYziUUTGRAaDqvpEIQ/bNisyBb01wmUTFq8
	 R8X7fomkvsvFLsCvpjgYu4Da6lXcus39CHPMdxkSZteezAwmtau8l4EQPC3XHLjROe988Hyh9gYj
	 cLiRxOENFiun0ufmIxIa/6MFWw0RhqtGj3Uup7iIBQSF9fblu72GPbwNi18W2kPDfB06TW5nUBcf
	 mOQ7soKt+jQzNAZHk=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Alva Lan <alvalan9@foxmail.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.1.y] net: dsa: clean up FDB, MDB, VLAN entries on unbind
Date: Tue, 21 Apr 2026 15:36:35 +0800
X-OQ-MSGID: <20260421073635.531-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-240069-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nxp.com,kernel.org,foxmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[foxmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[foxmail.com:dkim,foxmail.com:email,qq.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,nxp.com:email]
X-Rspamd-Queue-Id: 3F6E4437B36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 7afb5fb42d4950f33af2732b8147c552659f79b7 ]

As explained in many places such as commit b117e1e8a86d ("net: dsa:
delete dsa_legacy_fdb_add and dsa_legacy_fdb_del"), DSA is written given
the assumption that higher layers have balanced additions/deletions.
As such, it only makes sense to be extremely vocal when those
assumptions are violated and the driver unbinds with entries still
present.

But Ido Schimmel points out a very simple situation where that is wrong:
https://lore.kernel.org/netdev/ZDazSM5UsPPjQuKr@shredder/
(also briefly discussed by me in the aforementioned commit).

Basically, while the bridge bypass operations are not something that DSA
explicitly documents, and for the majority of DSA drivers this API
simply causes them to go to promiscuous mode, that isn't the case for
all drivers. Some have the necessary requirements for bridge bypass
operations to do something useful - see dsa_switch_supports_uc_filtering().

Although in tools/testing/selftests/net/forwarding/local_termination.sh,
we made an effort to popularize better mechanisms to manage address
filters on DSA interfaces from user space - namely macvlan for unicast,
and setsockopt(IP_ADD_MEMBERSHIP) - through mtools - for multicast, the
fact is that 'bridge fdb add ... self static local' also exists as
kernel UAPI, and might be useful to someone, even if only for a quick
hack.

It seems counter-productive to block that path by implementing shim
.ndo_fdb_add and .ndo_fdb_del operations which just return -EOPNOTSUPP
in order to prevent the ndo_dflt_fdb_add() and ndo_dflt_fdb_del() from
running, although we could do that.

Accepting that cleanup is necessary seems to be the only option.
Especially since we appear to be coming back at this from a different
angle as well. Russell King is noticing that the WARN_ON() triggers even
for VLANs:
https://lore.kernel.org/netdev/Z_li8Bj8bD4-BYKQ@shell.armlinux.org.uk/

What happens in the bug report above is that dsa_port_do_vlan_del() fails,
then the VLAN entry lingers on, and then we warn on unbind and leak it.

This is not a straight revert of the blamed commit, but we now add an
informational print to the kernel log (to still have a way to see
that bugs exist), and some extra comments gathered from past years'
experience, to justify the logic.

Fixes: 0832cd9f1f02 ("net: dsa: warn if port lists aren't empty in dsa_port_teardown")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://patch.msgid.link/20250414212930.2956310-1-vladimir.oltean@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Apply the patch to net/dsa/dsa2.c in v6.1 since commit
47d2ce03dcfb ("net: dsa: rename dsa2.c back into dsa.c and create its header")
renamed this file to net/dsa/dsa.c starting from v6.2. ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 net/dsa/dsa2.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index 415e856ba0ac..9ecb5e34e484 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -1738,12 +1738,44 @@ static int dsa_switch_parse(struct dsa_switch *ds, struct dsa_chip_data *cd)
 
 static void dsa_switch_release_ports(struct dsa_switch *ds)
 {
+	struct dsa_mac_addr *a, *tmp;
 	struct dsa_port *dp, *next;
+	struct dsa_vlan *v, *n;
 
 	dsa_switch_for_each_port_safe(dp, next, ds) {
-		WARN_ON(!list_empty(&dp->fdbs));
-		WARN_ON(!list_empty(&dp->mdbs));
-		WARN_ON(!list_empty(&dp->vlans));
+		/* These are either entries that upper layers lost track of
+		 * (probably due to bugs), or installed through interfaces
+		 * where one does not necessarily have to remove them, like
+		 * ndo_dflt_fdb_add().
+		 */
+		list_for_each_entry_safe(a, tmp, &dp->fdbs, list) {
+			dev_info(ds->dev,
+				 "Cleaning up unicast address %pM vid %u from port %d\n",
+				 a->addr, a->vid, dp->index);
+			list_del(&a->list);
+			kfree(a);
+		}
+
+		list_for_each_entry_safe(a, tmp, &dp->mdbs, list) {
+			dev_info(ds->dev,
+				 "Cleaning up multicast address %pM vid %u from port %d\n",
+				 a->addr, a->vid, dp->index);
+			list_del(&a->list);
+			kfree(a);
+		}
+
+		/* These are entries that upper layers have lost track of,
+		 * probably due to bugs, but also due to dsa_port_do_vlan_del()
+		 * having failed and the VLAN entry still lingering on.
+		 */
+		list_for_each_entry_safe(v, n, &dp->vlans, list) {
+			dev_info(ds->dev,
+				 "Cleaning up vid %u from port %d\n",
+				 v->vid, dp->index);
+			list_del(&v->list);
+			kfree(v);
+		}
+
 		list_del(&dp->list);
 		kfree(dp);
 	}
-- 
2.43.0


