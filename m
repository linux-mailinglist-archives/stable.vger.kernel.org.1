Return-Path: <stable+bounces-231072-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFT6Aj1Gymnn7AUAu9opvQ
	(envelope-from <stable+bounces-231072-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:45:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5267E3586ED
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88A3C30A76FB
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C085B3B4E9C;
	Mon, 30 Mar 2026 09:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="amgURLRg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E575A3B47F5
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863396; cv=none; b=MgD9jVTpg6EyUSHbZqV6nU+3tUb9rRTxrbj3p388qOyPeYmhhzD+IZRecteSvFcrF1R0h/TnrblFwkaMOAasjb6VoqDHgtwjrNRuj2FteHBCwTszfte8sf0CRRYUpD/GLlr0NkB28BI3ANf/hr4QW3WUDC954C1Grq8XDiuWAwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863396; c=relaxed/simple;
	bh=WWAkhZXYxoMIeq8KpIbN9VKybY7Mo/2eFwiASI2ptbg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OsnHOMNe3u45Pp8hSjakud5znbRVnFZhfCGDj1sVMJx/PAyFuUz6uIsZ0auOwwJ5b3Ir6/r+udPVBVjgZYbWLlRsvd51Rc2rwuoAxp0vYfYzyShqZhg+lp1xA1ShIKyOgX0sQ2/fI7Bm+ePZp3MlZnAcFWl0znfL7lk0jtryl9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=amgURLRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4062C4CEF7;
	Mon, 30 Mar 2026 09:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774863395;
	bh=WWAkhZXYxoMIeq8KpIbN9VKybY7Mo/2eFwiASI2ptbg=;
	h=Subject:To:Cc:From:Date:From;
	b=amgURLRgUo3gqfq/h/CrQ+qdKwTbIA7VCbipZBLiq+qGZjeLpp8X+QMuJIbRPTol/
	 YBhswIFrpuMPW5DX7Mb4wgufT1VQn9BrcW5tP4PDLYJ40tMpCeP/NIeCtNP3dGH3IS
	 fQY1nXn+yNGqVaremKXkul5SK6rhmi6xa2rw4yKE=
Subject: FAILED: patch "[PATCH] ovl: make fsync after metadata copy-up opt-in mount option" failed to apply to 6.12-stable tree
To: feilv@asrmicro.com,amir73il@gmail.com,chenglongtang@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Mar 2026 11:36:31 +0200
Message-ID: <2026033031-backpack-decorator-faaa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231072-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[asrmicro.com,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5267E3586ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 1f6ee9be92f8df85a8c9a5a78c20fd39c0c21a95
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026033031-backpack-decorator-faaa@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1f6ee9be92f8df85a8c9a5a78c20fd39c0c21a95 Mon Sep 17 00:00:00 2001
From: Fei Lv <feilv@asrmicro.com>
Date: Mon, 22 Jul 2024 18:14:43 +0800
Subject: [PATCH] ovl: make fsync after metadata copy-up opt-in mount option

Commit 7d6899fb69d25 ("ovl: fsync after metadata copy-up") was done to
fix durability of overlayfs copy up on an upper filesystem which does
not enforce ordering on storing of metadata changes (e.g. ubifs).

In an earlier revision of the regressing commit by Lei Lv, the metadata
fsync behavior was opt-in via a new "fsync=strict" mount option.
We were hoping that the opt-in mount option could be avoided, so the
change was only made to depend on metacopy=off, in the hope of not
hurting performance of metadata heavy workloads, which are more likely
to be using metacopy=on.

This hope was proven wrong by a performance regression report from Google
COS workload after upgrade to kernel 6.12.

This is an adaptation of Lei's original "fsync=strict" mount option
to the existing upstream code.

The new mount option is mutually exclusive with the "volatile" mount
option, so the latter is now an alias to the "fsync=volatile" mount
option.

Reported-by: Chenglong Tang <chenglongtang@google.com>
Closes: https://lore.kernel.org/linux-unionfs/CAOdxtTadAFH01Vui1FvWfcmQ8jH1O45owTzUcpYbNvBxnLeM7Q@mail.gmail.com/
Link: https://lore.kernel.org/linux-unionfs/CAOQ4uxgKC1SgjMWre=fUb00v8rxtd6sQi-S+dxR8oDzAuiGu8g@mail.gmail.com/
Fixes: 7d6899fb69d25 ("ovl: fsync after metadata copy-up")
Depends: 50e638beb67e0 ("ovl: Use str_on_off() helper in ovl_show_options()")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Fei Lv <feilv@asrmicro.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>

diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
index af5a69f87da4..eb846518e6ac 100644
--- a/Documentation/filesystems/overlayfs.rst
+++ b/Documentation/filesystems/overlayfs.rst
@@ -783,6 +783,56 @@ controlled by the "uuid" mount option, which supports these values:
     mounted with "uuid=on".
 
 
+Durability and copy up
+----------------------
+
+The fsync(2) system call ensures that the data and metadata of a file
+are safely written to the backing storage, which is expected to
+guarantee the existence of the information post system crash.
+
+Without an fsync(2) call, there is no guarantee that the observed
+data after a system crash will be either the old or the new data, but
+in practice, the observed data after crash is often the old or new data
+or a mix of both.
+
+When an overlayfs file is modified for the first time, copy up will
+create a copy of the lower file and its parent directories in the upper
+layer.  Since the Linux filesystem API does not enforce any particular
+ordering on storing changes without explicit fsync(2) calls, in case
+of a system crash, the upper file could end up with no data at all
+(i.e. zeros), which would be an unusual outcome.  To avoid this
+experience, overlayfs calls fsync(2) on the upper file before completing
+data copy up with rename(2) or link(2) to make the copy up "atomic".
+
+By default, overlayfs does not explicitly call fsync(2) on copied up
+directories or on metadata-only copy up, so it provides no guarantee to
+persist the user's modification unless the user calls fsync(2).
+The fsync during copy up only guarantees that if a copy up is observed
+after a crash, the observed data is not zeroes or intermediate values
+from the copy up staging area.
+
+On traditional local filesystems with a single journal (e.g. ext4, xfs),
+fsync on a file also persists the parent directory changes, because they
+are usually modified in the same transaction, so metadata durability during
+data copy up effectively comes for free.  Overlayfs further limits risk by
+disallowing network filesystems as upper layer.
+
+Overlayfs can be tuned to prefer performance or durability when storing
+to the underlying upper layer.  This is controlled by the "fsync" mount
+option, which supports these values:
+
+- "auto": (default)
+    Call fsync(2) on upper file before completion of data copy up.
+    No explicit fsync(2) on directory or metadata-only copy up.
+- "strict":
+    Call fsync(2) on upper file and directories before completion of any
+    copy up.
+- "volatile": [*]
+    Prefer performance over durability (see `Volatile mount`_)
+
+[*] The mount option "volatile" is an alias to "fsync=volatile".
+
+
 Volatile mount
 --------------
 
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 758611ee4475..13cb60b52bd6 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -1146,15 +1146,15 @@ static int ovl_copy_up_one(struct dentry *parent, struct dentry *dentry,
 		return -EOVERFLOW;
 
 	/*
-	 * With metacopy disabled, we fsync after final metadata copyup, for
+	 * With "fsync=strict", we fsync after final metadata copyup, for
 	 * both regular files and directories to get atomic copyup semantics
 	 * on filesystems that do not use strict metadata ordering (e.g. ubifs).
 	 *
-	 * With metacopy enabled we want to avoid fsync on all meta copyup
+	 * By default, we want to avoid fsync on all meta copyup, because
 	 * that will hurt performance of workloads such as chown -R, so we
 	 * only fsync on data copyup as legacy behavior.
 	 */
-	ctx.metadata_fsync = !OVL_FS(dentry->d_sb)->config.metacopy &&
+	ctx.metadata_fsync = ovl_should_sync_metadata(OVL_FS(dentry->d_sb)) &&
 			     (S_ISREG(ctx.stat.mode) || S_ISDIR(ctx.stat.mode));
 	ctx.metacopy = ovl_need_meta_copy_up(dentry, ctx.stat.mode, flags);
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index cad2055ebf18..63b299bf12f7 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -99,6 +99,12 @@ enum {
 	OVL_VERITY_REQUIRE,
 };
 
+enum {
+	OVL_FSYNC_VOLATILE,
+	OVL_FSYNC_AUTO,
+	OVL_FSYNC_STRICT,
+};
+
 /*
  * The tuple (fh,uuid) is a universal unique identifier for a copy up origin,
  * where:
@@ -656,6 +662,21 @@ static inline bool ovl_xino_warn(struct ovl_fs *ofs)
 	return ofs->config.xino == OVL_XINO_ON;
 }
 
+static inline bool ovl_should_sync(struct ovl_fs *ofs)
+{
+	return ofs->config.fsync_mode != OVL_FSYNC_VOLATILE;
+}
+
+static inline bool ovl_should_sync_metadata(struct ovl_fs *ofs)
+{
+	return ofs->config.fsync_mode == OVL_FSYNC_STRICT;
+}
+
+static inline bool ovl_is_volatile(struct ovl_config *config)
+{
+	return config->fsync_mode == OVL_FSYNC_VOLATILE;
+}
+
 /*
  * To avoid regressions in existing setups with overlay lower offline changes,
  * we allow lower changes only if none of the new features are used.
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index 1d4828dbcf7a..80cad4ea96a3 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -18,7 +18,7 @@ struct ovl_config {
 	int xino;
 	bool metacopy;
 	bool userxattr;
-	bool ovl_volatile;
+	int fsync_mode;
 };
 
 struct ovl_sb {
@@ -120,11 +120,6 @@ static inline struct ovl_fs *OVL_FS(struct super_block *sb)
 	return (struct ovl_fs *)sb->s_fs_info;
 }
 
-static inline bool ovl_should_sync(struct ovl_fs *ofs)
-{
-	return !ofs->config.ovl_volatile;
-}
-
 static inline unsigned int ovl_numlower(struct ovl_entry *oe)
 {
 	return oe ? oe->__numlower : 0;
diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 8111b437ae5d..c93fcaa45d4a 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -58,6 +58,7 @@ enum ovl_opt {
 	Opt_xino,
 	Opt_metacopy,
 	Opt_verity,
+	Opt_fsync,
 	Opt_volatile,
 	Opt_override_creds,
 };
@@ -140,6 +141,23 @@ static int ovl_verity_mode_def(void)
 	return OVL_VERITY_OFF;
 }
 
+static const struct constant_table ovl_parameter_fsync[] = {
+	{ "volatile",	OVL_FSYNC_VOLATILE },
+	{ "auto",	OVL_FSYNC_AUTO     },
+	{ "strict",	OVL_FSYNC_STRICT   },
+	{}
+};
+
+static const char *ovl_fsync_mode(struct ovl_config *config)
+{
+	return ovl_parameter_fsync[config->fsync_mode].name;
+}
+
+static int ovl_fsync_mode_def(void)
+{
+	return OVL_FSYNC_AUTO;
+}
+
 const struct fs_parameter_spec ovl_parameter_spec[] = {
 	fsparam_string_empty("lowerdir",    Opt_lowerdir),
 	fsparam_file_or_string("lowerdir+", Opt_lowerdir_add),
@@ -155,6 +173,7 @@ const struct fs_parameter_spec ovl_parameter_spec[] = {
 	fsparam_enum("xino",                Opt_xino, ovl_parameter_xino),
 	fsparam_enum("metacopy",            Opt_metacopy, ovl_parameter_bool),
 	fsparam_enum("verity",              Opt_verity, ovl_parameter_verity),
+	fsparam_enum("fsync",               Opt_fsync, ovl_parameter_fsync),
 	fsparam_flag("volatile",            Opt_volatile),
 	fsparam_flag_no("override_creds",   Opt_override_creds),
 	{}
@@ -665,8 +684,11 @@ static int ovl_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_verity:
 		config->verity_mode = result.uint_32;
 		break;
+	case Opt_fsync:
+		config->fsync_mode = result.uint_32;
+		break;
 	case Opt_volatile:
-		config->ovl_volatile = true;
+		config->fsync_mode = OVL_FSYNC_VOLATILE;
 		break;
 	case Opt_userxattr:
 		config->userxattr = true;
@@ -800,6 +822,7 @@ int ovl_init_fs_context(struct fs_context *fc)
 	ofs->config.nfs_export		= ovl_nfs_export_def;
 	ofs->config.xino		= ovl_xino_def();
 	ofs->config.metacopy		= ovl_metacopy_def;
+	ofs->config.fsync_mode		= ovl_fsync_mode_def();
 
 	fc->s_fs_info		= ofs;
 	fc->fs_private		= ctx;
@@ -870,9 +893,9 @@ int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
 		config->index = false;
 	}
 
-	if (!config->upperdir && config->ovl_volatile) {
+	if (!config->upperdir && ovl_is_volatile(config)) {
 		pr_info("option \"volatile\" is meaningless in a non-upper mount, ignoring it.\n");
-		config->ovl_volatile = false;
+		config->fsync_mode = ovl_fsync_mode_def();
 	}
 
 	if (!config->upperdir && config->uuid == OVL_UUID_ON) {
@@ -1070,8 +1093,8 @@ int ovl_show_options(struct seq_file *m, struct dentry *dentry)
 		seq_printf(m, ",xino=%s", ovl_xino_mode(&ofs->config));
 	if (ofs->config.metacopy != ovl_metacopy_def)
 		seq_printf(m, ",metacopy=%s", str_on_off(ofs->config.metacopy));
-	if (ofs->config.ovl_volatile)
-		seq_puts(m, ",volatile");
+	if (ofs->config.fsync_mode != ovl_fsync_mode_def())
+		seq_printf(m, ",fsync=%s", ovl_fsync_mode(&ofs->config));
 	if (ofs->config.userxattr)
 		seq_puts(m, ",userxattr");
 	if (ofs->config.verity_mode != ovl_verity_mode_def())
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index d4c12feec039..0822987cfb51 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -776,7 +776,7 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 	 * For volatile mount, create a incompat/volatile/dirty file to keep
 	 * track of it.
 	 */
-	if (ofs->config.ovl_volatile) {
+	if (ovl_is_volatile(&ofs->config)) {
 		err = ovl_create_volatile_dirty(ofs);
 		if (err < 0) {
 			pr_err("Failed to create volatile/dirty file.\n");


