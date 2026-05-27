Return-Path: <stable+bounces-254469-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFZ1IRVeFmrelwcAu9opvQ
	(envelope-from <stable+bounces-254469-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 04:59:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1215DEC14
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 04:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A35C3010233
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 02:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B4C2D73AE;
	Wed, 27 May 2026 02:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UysuvIhR"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4CF378D71
	for <stable@vger.kernel.org>; Wed, 27 May 2026 02:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779850764; cv=none; b=q03v7zehny9hYxcgROGnIfM2R9x19IlD1s32w9yJFqg1KGQwdWHV9cKRsKqiPD0sGkmyxJ/fp3cHlyGWMx+24XROJMBxB+eDXU/QSRFz9K+uJbrXYtdlSdiTpksG+ysvdti0fXVLKG+PBUoyop5ufX4209fHjihzT+HcEW4unbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779850764; c=relaxed/simple;
	bh=kjicujkA5E7r76arGyOQ0yL2KoWTZqaFbfby1uBLO1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRMJgbVeKYt+2qdikZBnKKBedtdFiSxJEB90VgsPmWg2tdCRJs7KVVRTdLCvx7xtOAm9i1CUS1AnZ+VaVGDuXz+unuExLlpwv4QNIgOrfW0EbFHrkjBrBOCPrCyb6M8QnoySNFvQHK+yuO4KvJDie+gKJrlWguJTIFGLuJ6HfEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UysuvIhR; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-69d5730c579so3708956eaf.0
        for <stable@vger.kernel.org>; Tue, 26 May 2026 19:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779850762; x=1780455562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zegv+ZZxpEC4mW2h/ysZZnf1Sps69/IlZUIElRjQ8+k=;
        b=UysuvIhRG5IcrkrkpEDoV7+WWk473J0TvePpbTuLr4pyCyi3y+WiFjewZzZyIaC7E2
         eTpnoPuO2p644Z4CtwWcpeZWfXP63vY3rCyz+sK8DUYhBgK9yCFT394aTpsDDivGCWyi
         94AIkY7STXGsywlqEia4Gp3RSsj4iJmeXGffnHQqFJh8Upz6r2eEFDAVJNjc9LeLFmA8
         4UWvlBoJbNTQLwNymFdBcEN6aykfLIwxaWDtU1PoI1E7Eo3qCDpTOI+IazY7gPfYLwL8
         1D4PuDk6vRN3jVED6WEYpSIXspyNOl4z5zjyOzHiMfwsXAO9IOJ9ypNosxMzFOk3AqsI
         kpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779850762; x=1780455562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zegv+ZZxpEC4mW2h/ysZZnf1Sps69/IlZUIElRjQ8+k=;
        b=m4d/Des5+5LOvR+YPbU529bYBbS+AOKABlPRbNs4OrI+iIVFApszld6r8YHZ0wo6Zp
         0lZbQoGylxji8F8h+kb7cIn1bnbK7Jh0821yUZcH43vBm6raovaxtPkZhNH3lyCdxDhf
         Wr1c1V86bLu0hwV4F6jJIQqrjzOLrMMlP+hEpUVEYlprE0TVNqifROGqi6AKwlyI0kWc
         J+D20+Ln3JuqYUZBd7u1+VUSJmG41NPefNUR9+hMX3OJJhrzNwIEXjzU4QIFqbyqlpCe
         5DbW8XQaBV1JeUQWkxbc+9R6K75ggWaw9+aN7FAo2zIWQ5h+pLWYupBZopHzdAzu08Jy
         rI/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/JT2q5IoGrS28If1aLT/W0joYQXyT0Y14HAXtBRQvNfr+olcCi4rgMqfil5igCr+zEZIXaN+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YymgEVJ5okkkFBAq0Orm4CUlAKZEMUQsMMTWbWHRgBsxqB1rJlw
	fOFHlCd9AwdWjaZn48lUAEfDBoPPVVRRJm5CMceOs81+UuEALJyijijs2eTt11T5
X-Gm-Gg: Acq92OEH1jG3R9LzFzWgkjodB4cuQUR5g/kv+r1O6Gm8bwuvDKRQTrQz91uqzAh20w5
	J403Hg3JmiKCEHKWd5VBLzehBbnRk2WWvFUP4L+5Oh6ND7teiWHPePS/R6PeEaZ/bxOZdyUwW67
	MfSeGy/6rSFfUB/PadiQzGycx8nquQ7HTRp+4Xv4Pg/UNSa37dFfjDwVlMJhoILHJ6LCQrczx0h
	6BJ+Dtk+3Vvoy+UEOPx8OKQhlxCbZeGtktJviFf8x1Zg5OloNCEkqCzTfg2UqURo2odsJUwZaaX
	+Rj3gs85h5+J5lmu7uZSd+HWQDyNxytib7bItv5XRr63Nob9lBtmfLiAR7wFY4HGHHPyG/6VtF/
	HtcgFKo0dWRZI6RG9UpChk5XKendMFqMGa9SN9P87ERASTn39HrmuhrokVKvjRhhSjyI5WGZvAD
	UCVs+9Fe5ejvq8WVKH2gFK8fCXfBTVfPeJAjJRrPkAZHoqpixyQdrFXF9UB7s=
X-Received: by 2002:a05:6820:1748:b0:696:17a6:c06f with SMTP id 006d021491bc7-69d7ead4fa3mr11345857eaf.12.1779850762129;
        Tue, 26 May 2026 19:59:22 -0700 (PDT)
Received: from localhost (static-23-234-115-121.cust.tzulo.com. [23.234.115.121])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-43b63976d57sm15305313fac.9.2026.05.26.19.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 19:59:21 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	Xiubo Li <xiubli@redhat.com>,
	Milind Changire <mchangir@redhat.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] ceph: properly decrypt filenames in vmalloc() buffers
Date: Tue, 26 May 2026 19:58:28 -0700
Message-ID: <20260527025828.5966-3-CFSworks@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527025828.5966-1-CFSworks@gmail.com>
References: <20260527025828.5966-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,dubeyko.com];
	TAGGED_FROM(0.00)[bounces-254469-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,iname.name:url]
X-Rspamd-Queue-Id: AD1215DEC14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The fscrypt subsystem uses the scatterlist crypto API, inheriting its
requirement that any buffers are in the linear mapping region. However,
the messenger client uses kvmalloc() to create buffers for messages,
which will occasionally place those buffers in the vmalloc() region when
physical memory fragmentation doesn't permit a large enough kmalloc().
The various callers of ceph_fname_to_usr() directly pass (slices of) raw
messages from the MDS without considering that the messages may be in
vmalloc() buffers, resulting in oopses especially on non-x86 platforms
(see 'Closes:' for more details and a reproducer).

Make ceph_fname_to_usr() explicitly tolerant of vmalloc()-allocated
fname->ctext, fname->name, and/or oname->name buffers, using `tname`
(which, when non-null, must be a linear address; when null, is briefly
allocated as necessary) as a bounce buffer to avoid passing any
inappropriate addresses to fscrypt_fname_disk_to_usr().

Additionally change parse_reply_info_readdir() -- the only function to
supply its own `tname` -- to follow the new "tname must never come from
vmalloc()" rule by passing NULL when the message is not in the linear
region. Though this causes a per-dentry kmalloc()+kfree(), this overhead
exists only when processing the minority of messages that spill into
vmalloc(). My (crude) testing puts this at only about 1 in 8,000 readdir
messages. Still, if the overhead proves unreasonable in the future, it
is easy enough to mitigate: a future change could allocate a bounce
buffer in parse_reply_info_readdir() and use that as `tname` instead.

Fixes: 457117f077c67 ("ceph: add helpers for converting names for userland presentation")
Closes: https://lore.kernel.org/ceph-devel/CAH5Ym4ga7miUQE0K-cJA93Ya7w62P69MAN27R5cBiYnudoOHdA@mail.gmail.com/T/
Cc: stable@vger.kernel.org # v6.6+
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 fs/ceph/crypto.c     | 37 +++++++++++++++++++++++++++++--------
 fs/ceph/mds_client.c |  8 ++++++--
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 7515cb251226..61d6830d16bc 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -298,6 +298,10 @@ int ceph_encode_encrypted_dname(struct inode *parent, char *buf, int elen)
  * Otherwise, base64 decode the string, and then ask fscrypt to format it
  * for userland presentation.
  *
+ * Though the fscrypt/crypto subsystems broadly expect all buffers to be in the
+ * linear-mapped region, this function slightly relaxes those requirements:
+ * fname->ctext, fname->name, and oname->name may be vmalloc(), but not tname.
+ *
  * Returns 0 on success or negative error code on error.
  */
 int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char *tname,
@@ -305,11 +309,15 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char *tname,
 {
 	struct inode *dir = fname->dir;
 	struct fscrypt_str _tname = FSTR_INIT(NULL, 0);
+	struct fscrypt_str _oname;
 	struct fscrypt_str iname;
 	char *name = fname->name;
 	int name_len = fname->name_len;
 	int ret;
 
+	if (WARN_ON_ONCE(tname && is_vmalloc_addr(tname)))
+		return -EIO;
+
 	/* Sanity check that the resulting name will fit in the buffer */
 	if (fname->name_len > NAME_MAX || fname->ctext_len > NAME_MAX)
 		return -EIO;
@@ -350,16 +358,18 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char *tname,
 		goto out_inode;
 	}
 
+	if (!tname && (fname->ctext_len == 0 ||
+		       unlikely(is_vmalloc_addr(fname->ctext)) ||
+		       unlikely(is_vmalloc_addr(oname->name)))) {
+		ret = fscrypt_fname_alloc_buffer(NAME_MAX, &_tname);
+		if (ret)
+			goto out_inode;
+		tname = _tname.name;
+	}
+
 	if (fname->ctext_len == 0) {
 		int declen;
 
-		if (!tname) {
-			ret = fscrypt_fname_alloc_buffer(NAME_MAX, &_tname);
-			if (ret)
-				goto out_inode;
-			tname = _tname.name;
-		}
-
 		declen = base64_decode(name, name_len, tname, false,
 				       BASE64_IMAP);
 		if (declen <= 0) {
@@ -368,12 +378,21 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char *tname,
 		}
 		iname.name = tname;
 		iname.len = declen;
+	} else if (unlikely(is_vmalloc_addr(fname->ctext))) {
+		memcpy(tname, fname->ctext, fname->ctext_len);
+
+		iname.name = tname;
+		iname.len = fname->ctext_len;
 	} else {
 		iname.name = fname->ctext;
 		iname.len = fname->ctext_len;
 	}
 
-	ret = fscrypt_fname_disk_to_usr(dir, 0, 0, &iname, oname);
+	_oname.name = unlikely(is_vmalloc_addr(oname->name)) ?
+		tname : oname->name;
+	_oname.len = oname->len;
+	ret = fscrypt_fname_disk_to_usr(dir, 0, 0, &iname, &_oname);
+	oname->len = _oname.len;
 	if (!ret && (dir != fname->dir)) {
 		char tmp_buf[BASE64_CHARS(NAME_MAX)];
 
@@ -381,6 +400,8 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char *tname,
 				    oname->len, oname->name, dir->i_ino);
 		memcpy(oname->name, tmp_buf, name_len);
 		oname->len = name_len;
+	} else if (!ret && unlikely(is_vmalloc_addr(oname->name))) {
+		memcpy(oname->name, _oname.name, _oname.len);
 	}
 
 out:
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index aa6730b48e97..8fcf185e3a82 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -538,9 +538,13 @@ static int parse_reply_info_readdir(void **p, void *end,
 			 * to do the base64_decode in-place. It's
 			 * safe because the decoded string should
 			 * always be shorter, which is 3/4 of origin
-			 * string.
+			 * string. If this message was allocated with
+			 * vmalloc() (happens, but rarely), leave it
+			 * NULL and let ceph_fname_to_usr() allocate
+			 * suitable temporary working space instead.
 			 */
-			tname = _name;
+			if (likely(!is_vmalloc_addr(_name)))
+				tname = _name;
 
 			/*
 			 * Set oname to _name too, and this will be
-- 
2.53.0


