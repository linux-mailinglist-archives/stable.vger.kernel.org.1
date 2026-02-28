Return-Path: <stable+bounces-220450-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFWwJLw7o2nO+gQAu9opvQ
	(envelope-from <stable+bounces-220450-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:02:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4DE1C686F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DDF03291FE9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260E8481237;
	Sat, 28 Feb 2026 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NG8Ek/p1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF853B775C;
	Sat, 28 Feb 2026 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300338; cv=none; b=E9Gdle7n1j+iuyuBseWD8XSW90vqp+3EBEMe5hsRqypitJm/7u53jioRIEWqfQ+BmX5CDNca0yRPJ4JUUyuofjH+SJptlP4BpM64Fz3N5+fx6aUL339ds/DzEyfAzU2mYLnnfRBIIBaJ8En6W3QUv9YW7k8s0o2rpLxWbfL7l60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300338; c=relaxed/simple;
	bh=k6MRtvOHidhQD1Dwc8iePa7jUrChqt4sVoH4LSEX4nI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMk9K7g54pFTrJgA4WikM3+RBGyb9/Oiv3pY1tD5sqDYLprlojB0gECW8aNbl3ktV7/Wqh+5aSx8mcVu7gJks8BCFLnxPVXvtyi7pB5FwDOFHD6R6j82AX1gVU6JToXaMn1eVK97Itmj88k+aznA4/Yo+gz4ijmc8OcLXFDngzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NG8Ek/p1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7EAC19424;
	Sat, 28 Feb 2026 17:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300338;
	bh=k6MRtvOHidhQD1Dwc8iePa7jUrChqt4sVoH4LSEX4nI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NG8Ek/p1tjaNKVvMY0L6r8SsA5FovYjQNwvQzvdAe/o3n3jT+VLOV0XLf24QtSS3e
	 VoWf3TrZXjZ7jf1Uw2G57r8ELRZVBpeM2N2GCkEisA95iqYBTpPvXu/uNDkskB5TLt
	 Tm30fB/Ng6XZny0DQQBMC6JSo02eceG8wEKxn+ja2RcUW7fjZ4Yj1EQZc6VmO+wxXs
	 QGPz/ywku5Ehjg3fcyJ4ehkP3XAodbwYNv5Va6NrbgbZIwUkuzYAKFMNhTp4lIdlxI
	 9Z1+Vhjxhowxwvl+5ZtXeyPkgpGEGhB0SeFbWsDVmlw7okmVFHElpWubjiAontmw2L
	 A3auCsGJdQX3A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 371/844] tty: vt/keyboard: Split apart vt_do_diacrit()
Date: Sat, 28 Feb 2026 12:24:44 -0500
Message-ID: <20260228173244.1509663-372-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220450-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,intel.com:email]
X-Rspamd-Queue-Id: DC4DE1C686F
X-Rspamd-Action: no action

From: Nathan Chancellor <nathan@kernel.org>

[ Upstream commit 0a76a17238f805b231d97b118232a5185bbb7a18 ]

After commit bfb24564b5fd ("tty: vt/keyboard: use __free()"), builds
using asm goto for put_user() and get_user() with a version of clang
older than 17 error with:

  drivers/tty/vt/keyboard.c:1709:7: error: cannot jump from this asm goto statement to one of its possible targets
                  if (put_user(asize, &a->kb_cnt))
                      ^
  ...
  arch/arm64/include/asm/uaccess.h:298:2: note: expanded from macro '__put_mem_asm'
          asm goto(                                                       \
          ^
  drivers/tty/vt/keyboard.c:1687:7: note: possible target of asm goto statement
                  if (put_user(asize, &a->kb_cnt))
                      ^
  ...
  arch/arm64/include/asm/uaccess.h:342:2: note: expanded from macro '__raw_put_user'
          __rpu_failed:                                                   \
          ^
  drivers/tty/vt/keyboard.c:1697:23: note: jump exits scope of variable with __attribute__((cleanup))
                  void __free(kfree) *buf = kmalloc_array(MAX_DIACR, sizeof(struct kbdiacruc),
                                      ^
  drivers/tty/vt/keyboard.c:1671:33: note: jump bypasses initialization of variable with __attribute__((cleanup))
                  struct kbdiacr __free(kfree) *dia = kmalloc_array(MAX_DIACR, sizeof(struct kbdiacr),
                                                ^

Prior to a fix to clang's scope checker in clang 17 [1], all labels in a
function were validated as potential targets of all asm gotos in a
function, regardless of whether they actually were a target of an asm
goto call, resulting in false positive errors about skipping over
variables marked with the cleanup attribute.

To workaround this error, split up the bodies of the case statements in
vt_do_diacrit() into their own functions so that the scope checker does
not trip up on the multiple instances of __free().

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202509091702.Oc7eCRDw-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202511241835.EA8lShgH-lkp@intel.com/
Link: https://github.com/llvm/llvm-project/commit/f023f5cdb2e6c19026f04a15b5a935c041835d14 [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Link: https://patch.msgid.link/20251125-tty-vt-keyboard-wa-clang-scope-check-error-v1-1-f5a5ea55c578@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/vt/keyboard.c | 221 ++++++++++++++++++++------------------
 1 file changed, 115 insertions(+), 106 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index d65fc60dd7bed..3538d54d6a6ac 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1649,134 +1649,143 @@ int __init kbd_init(void)
 
 /* Ioctl support code */
 
-/**
- *	vt_do_diacrit		-	diacritical table updates
- *	@cmd: ioctl request
- *	@udp: pointer to user data for ioctl
- *	@perm: permissions check computed by caller
- *
- *	Update the diacritical tables atomically and safely. Lock them
- *	against simultaneous keypresses
- */
-int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
+static int vt_do_kdgkbdiacr(void __user *udp)
 {
-	int asize;
-
-	switch (cmd) {
-	case KDGKBDIACR:
-	{
-		struct kbdiacrs __user *a = udp;
-		int i;
+	struct kbdiacrs __user *a = udp;
+	int i, asize;
 
-		struct kbdiacr __free(kfree) *dia = kmalloc_array(MAX_DIACR, sizeof(struct kbdiacr),
-								  GFP_KERNEL);
-		if (!dia)
-			return -ENOMEM;
+	struct kbdiacr __free(kfree) *dia = kmalloc_array(MAX_DIACR, sizeof(struct kbdiacr),
+							  GFP_KERNEL);
+	if (!dia)
+		return -ENOMEM;
 
-		/* Lock the diacriticals table, make a copy and then
-		   copy it after we unlock */
-		scoped_guard(spinlock_irqsave, &kbd_event_lock) {
-			asize = accent_table_size;
-			for (i = 0; i < asize; i++) {
-				dia[i].diacr = conv_uni_to_8bit(accent_table[i].diacr);
-				dia[i].base = conv_uni_to_8bit(accent_table[i].base);
-				dia[i].result = conv_uni_to_8bit(accent_table[i].result);
-			}
+	/* Lock the diacriticals table, make a copy and then
+	   copy it after we unlock */
+	scoped_guard(spinlock_irqsave, &kbd_event_lock) {
+		asize = accent_table_size;
+		for (i = 0; i < asize; i++) {
+			dia[i].diacr = conv_uni_to_8bit(accent_table[i].diacr);
+			dia[i].base = conv_uni_to_8bit(accent_table[i].base);
+			dia[i].result = conv_uni_to_8bit(accent_table[i].result);
 		}
-
-		if (put_user(asize, &a->kb_cnt))
-			return -EFAULT;
-		if (copy_to_user(a->kbdiacr, dia, asize * sizeof(struct kbdiacr)))
-			return -EFAULT;
-		return 0;
 	}
-	case KDGKBDIACRUC:
-	{
-		struct kbdiacrsuc __user *a = udp;
 
-		void __free(kfree) *buf = kmalloc_array(MAX_DIACR, sizeof(struct kbdiacruc),
-							GFP_KERNEL);
-		if (buf == NULL)
-			return -ENOMEM;
+	if (put_user(asize, &a->kb_cnt))
+		return -EFAULT;
+	if (copy_to_user(a->kbdiacr, dia, asize * sizeof(struct kbdiacr)))
+		return -EFAULT;
+	return 0;
+}
 
-		/* Lock the diacriticals table, make a copy and then
-		   copy it after we unlock */
-		scoped_guard(spinlock_irqsave, &kbd_event_lock) {
-			asize = accent_table_size;
-			memcpy(buf, accent_table, asize * sizeof(struct kbdiacruc));
-		}
+static int vt_do_kdgkbdiacruc(void __user *udp)
+{
+	struct kbdiacrsuc __user *a = udp;
+	int asize;
 
-		if (put_user(asize, &a->kb_cnt))
-			return -EFAULT;
-		if (copy_to_user(a->kbdiacruc, buf, asize * sizeof(struct kbdiacruc)))
-			return -EFAULT;
+	void __free(kfree) *buf = kmalloc_array(MAX_DIACR, sizeof(struct kbdiacruc),
+						GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
 
-		return 0;
+	/* Lock the diacriticals table, make a copy and then
+	   copy it after we unlock */
+	scoped_guard(spinlock_irqsave, &kbd_event_lock) {
+		asize = accent_table_size;
+		memcpy(buf, accent_table, asize * sizeof(struct kbdiacruc));
 	}
 
-	case KDSKBDIACR:
-	{
-		struct kbdiacrs __user *a = udp;
-		struct kbdiacr __free(kfree) *dia = NULL;
-		unsigned int ct;
-		int i;
+	if (put_user(asize, &a->kb_cnt))
+		return -EFAULT;
+	if (copy_to_user(a->kbdiacruc, buf, asize * sizeof(struct kbdiacruc)))
+		return -EFAULT;
 
-		if (!perm)
-			return -EPERM;
-		if (get_user(ct, &a->kb_cnt))
-			return -EFAULT;
-		if (ct >= MAX_DIACR)
-			return -EINVAL;
+	return 0;
+}
 
-		if (ct) {
-			dia = memdup_array_user(a->kbdiacr,
-						ct, sizeof(struct kbdiacr));
-			if (IS_ERR(dia))
-				return PTR_ERR(dia);
-		}
+static int vt_do_kdskbdiacr(void __user *udp, int perm)
+{
+	struct kbdiacrs __user *a = udp;
+	struct kbdiacr __free(kfree) *dia = NULL;
+	unsigned int ct;
+	int i;
 
-		guard(spinlock_irqsave)(&kbd_event_lock);
-		accent_table_size = ct;
-		for (i = 0; i < ct; i++) {
-			accent_table[i].diacr =
-					conv_8bit_to_uni(dia[i].diacr);
-			accent_table[i].base =
-					conv_8bit_to_uni(dia[i].base);
-			accent_table[i].result =
-					conv_8bit_to_uni(dia[i].result);
-		}
+	if (!perm)
+		return -EPERM;
+	if (get_user(ct, &a->kb_cnt))
+		return -EFAULT;
+	if (ct >= MAX_DIACR)
+		return -EINVAL;
 
-		return 0;
+	if (ct) {
+		dia = memdup_array_user(a->kbdiacr,
+					ct, sizeof(struct kbdiacr));
+		if (IS_ERR(dia))
+			return PTR_ERR(dia);
 	}
 
-	case KDSKBDIACRUC:
-	{
-		struct kbdiacrsuc __user *a = udp;
-		unsigned int ct;
-		void __free(kfree) *buf = NULL;
+	guard(spinlock_irqsave)(&kbd_event_lock);
+	accent_table_size = ct;
+	for (i = 0; i < ct; i++) {
+		accent_table[i].diacr =
+				conv_8bit_to_uni(dia[i].diacr);
+		accent_table[i].base =
+				conv_8bit_to_uni(dia[i].base);
+		accent_table[i].result =
+				conv_8bit_to_uni(dia[i].result);
+	}
 
-		if (!perm)
-			return -EPERM;
+	return 0;
+}
 
-		if (get_user(ct, &a->kb_cnt))
-			return -EFAULT;
+static int vt_do_kdskbdiacruc(void __user *udp, int perm)
+{
+	struct kbdiacrsuc __user *a = udp;
+	unsigned int ct;
+	void __free(kfree) *buf = NULL;
 
-		if (ct >= MAX_DIACR)
-			return -EINVAL;
+	if (!perm)
+		return -EPERM;
 
-		if (ct) {
-			buf = memdup_array_user(a->kbdiacruc,
-						ct, sizeof(struct kbdiacruc));
-			if (IS_ERR(buf))
-				return PTR_ERR(buf);
-		}
-		guard(spinlock_irqsave)(&kbd_event_lock);
-		if (ct)
-			memcpy(accent_table, buf,
-					ct * sizeof(struct kbdiacruc));
-		accent_table_size = ct;
-		return 0;
+	if (get_user(ct, &a->kb_cnt))
+		return -EFAULT;
+
+	if (ct >= MAX_DIACR)
+		return -EINVAL;
+
+	if (ct) {
+		buf = memdup_array_user(a->kbdiacruc,
+					ct, sizeof(struct kbdiacruc));
+		if (IS_ERR(buf))
+			return PTR_ERR(buf);
 	}
+	guard(spinlock_irqsave)(&kbd_event_lock);
+	if (ct)
+		memcpy(accent_table, buf,
+				ct * sizeof(struct kbdiacruc));
+	accent_table_size = ct;
+	return 0;
+}
+
+/**
+ *	vt_do_diacrit		-	diacritical table updates
+ *	@cmd: ioctl request
+ *	@udp: pointer to user data for ioctl
+ *	@perm: permissions check computed by caller
+ *
+ *	Update the diacritical tables atomically and safely. Lock them
+ *	against simultaneous keypresses
+ */
+int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
+{
+	switch (cmd) {
+	case KDGKBDIACR:
+		return vt_do_kdgkbdiacr(udp);
+	case KDGKBDIACRUC:
+		return vt_do_kdgkbdiacruc(udp);
+	case KDSKBDIACR:
+		return vt_do_kdskbdiacr(udp, perm);
+	case KDSKBDIACRUC:
+		return vt_do_kdskbdiacruc(udp, perm);
 	}
 	return 0;
 }
-- 
2.51.0


