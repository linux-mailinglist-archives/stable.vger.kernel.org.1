Return-Path: <stable+bounces-23964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCCA869208
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237211C21D46
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ABF13EFFB;
	Tue, 27 Feb 2024 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bNB77hTw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B42913B2B3;
	Tue, 27 Feb 2024 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040650; cv=none; b=cofDijjT9PekB9Nb1sPLhfqELQkKvCwdSNStAr6W991C56a1UE2jWiZzaVFGsdy4q3rNzoM/IAKzWxT6VIfT/+uHj3VjY5Biyo5r/nZbjDSxSJAGFFOzIHOojWCUJuI/P6BkkwZRfmisii+6SoPXoFowBgq+XOT+Y2jBSSFeqXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040650; c=relaxed/simple;
	bh=MFKtR2fS4L0WjPDdjEGVFgoJTEjHDdqSj3YnJjAp2+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1YOq0BGmOGY22Jolbxt9cn6tx1DulcVhWdu2OkSTlj3HWQd+E1/Od6tBWbYVQshwjZsRoPds8G1g10zQZhmUsew5C0ZFEe8a/IlsERfgHhEn2/NmO25/4Dm7QxTNrodRuYfup011HOb+3ym91C2J+LMWibAZZecXWVuDhT+eWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bNB77hTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947ACC433F1;
	Tue, 27 Feb 2024 13:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709040650;
	bh=MFKtR2fS4L0WjPDdjEGVFgoJTEjHDdqSj3YnJjAp2+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bNB77hTwgcxSnvc4Le4q048uzOlXWmxGskWMDYJfRH2C0qwFA9FdU4aqkgMT5Hggg
	 Ktx8XyLJsufPdfdn5+dkmrsB1ryyp7AXgdymvjPdgey/jQL3eP1aATLCr3BSjEl41i
	 dQiVVoLCCouD7Nw8ePhyxRpBc5A4DkfSaq+Mnvd8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	llvm@lists.linux.dev,
	Kees Cook <keescook@chromium.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 022/334] smb: Work around Clang __bdos() type confusion
Date: Tue, 27 Feb 2024 14:18:00 +0100
Message-ID: <20240227131631.324135878@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 8deb05c84b63b4fdb8549e08942867a68924a5b8 ]

Recent versions of Clang gets confused about the possible size of the
"user" allocation, and CONFIG_FORTIFY_SOURCE ends up emitting a
warning[1]:

repro.c:126:4: warning: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
  126 |                         __write_overflow_field(p_size_field, size);
      |                         ^

for this memset():

        int len;
        __le16 *user;
	...
        len = ses->user_name ? strlen(ses->user_name) : 0;
        user = kmalloc(2 + (len * 2), GFP_KERNEL);
	...
	if (len) {
		...
	} else {
		memset(user, '\0', 2);
	}

While Clang works on this bug[2], switch to using a direct assignment,
which avoids memset() entirely which both simplifies the code and silences
the false positive warning. (Making "len" size_t also silences the
warning, but the direct assignment seems better.)

Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://github.com/ClangBuiltLinux/linux/issues/1966 [1]
Link: https://github.com/llvm/llvm-project/issues/77813 [2]
Cc: Steve French <sfrench@samba.org>
Cc: Paulo Alcantara <pc@manguebit.com>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: linux-cifs@vger.kernel.org
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsencrypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/cifsencrypt.c b/fs/smb/client/cifsencrypt.c
index ef4c2e3c9fa61..6322f0f68a176 100644
--- a/fs/smb/client/cifsencrypt.c
+++ b/fs/smb/client/cifsencrypt.c
@@ -572,7 +572,7 @@ static int calc_ntlmv2_hash(struct cifs_ses *ses, char *ntlmv2_hash,
 		len = cifs_strtoUTF16(user, ses->user_name, len, nls_cp);
 		UniStrupr(user);
 	} else {
-		memset(user, '\0', 2);
+		*(u16 *)user = 0;
 	}
 
 	rc = crypto_shash_update(ses->server->secmech.hmacmd5,
-- 
2.43.0




