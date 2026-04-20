Return-Path: <stable+bounces-238733-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKH1C0EB5mkvqQEAu9opvQ
	(envelope-from <stable+bounces-238733-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 12:34:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AA74295FA
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 12:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCBA1302DB5D
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 10:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51F3398915;
	Mon, 20 Apr 2026 10:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="qaDmmnMp"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4787F2F260F;
	Mon, 20 Apr 2026 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776681275; cv=none; b=hxEqvo/JTHFVF7IsZK8LAvJb9bsd9EtEaFQX06OhvC5Da88SV6+KhihX6w9rxDlJc/K4gDoBxFGebyeFvYGxMDIqz/We8pH9nWzOOpNug9DujuG6qjhzdg/vtm+vhjmRqEPU+oFUth4WQQuYIQC3JonGFc22d877UihMflp2yLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776681275; c=relaxed/simple;
	bh=Ix8P7RnF0Rfhthxt4kOBqZyLHhMN56JNwg+Whyvbb2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bqaDs7mqxqRxMyu70iXaGHNOAxnCngow1c0rJfQvQyUBmsZ+rkdZFJGe8BczA6vSDpXYLWfrcvwOpqYN91dg6fNXxODfFRTVHq++xmSjZ9Q7bj0lzTGsEFqU0FBGJa6ljCwccDKHD16mb6QM1j5xhLi4jMjqA5ooFntqbrTrws8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=qaDmmnMp; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=sSyq707cDYongcfhhlIcwCv7VZwPwVTCVWAelVSlF2g=; b=qaDmmnMpCBiLtph6bMABgKqdZt
	XeeIgYSGHihFmxiSZrpm5tvC+CcL7n66dY98iVzr0KcLWY/3qo3a0vv75iNTOZVejoyanRR6HTHze
	hn3vGQw83gtsnbT8f7VRXGa0Yb0JO5t5aOdS6aS/gI0VZ30JalR8QPQqdfxeVcD1x9uV3B81aeNe1
	LK/SdN3Rx1J8LTa7SGG9E/+R+v9C7Hbx+HTxm8IvFHTcdvWXX1KtPshidl74mNy97lWdgD3w4TVzw
	Fyx1uQjV+tuB1Tnuve4mQIqNhPl/rzVpJSIDmD25lfQ0KYtzWVrNZvgSUWldv0F2bOYARuLBIXLtN
	Rm4ySZwg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wElxS-0001Sp-1A;
	Mon, 20 Apr 2026 10:34:26 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 20 Apr 2026 03:18:36 -0700
Subject: [PATCH net] netconsole: avoid out-of-bounds access on empty string
 in trim_newline()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-netcons_trim_newline-v1-1-dc35889aeedf@debian.org>
X-B4-Tracking: v=1; b=H4sIAHv95WkC/yXMQQrCMBAF0KuEv24gpiVoriJSbPzVEZ1KErVQe
 ndRt2/xFhRmYUE0CzJfUmRSRLNpDNLlqGdaOSEaeOeD67yzypomLX3Ncu+V75sobRvGwNQOu61
 3aAwemaPMv3YPZcXhj+U5XJnqN8S6fgDn09WxfQAAAA==
X-Change-ID: 20260420-netcons_trim_newline-36f6ec3b9820
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthew Wood <thepacketgeek@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, stable@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=1792; i=leitao@debian.org;
 h=from:subject:message-id; bh=Ix8P7RnF0Rfhthxt4kOBqZyLHhMN56JNwg+Whyvbb2M=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp5gEtYvbwBxczeM8ah4vitJErTLdkEfq5YVYQI
 nSI9NF9ZvuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaeYBLQAKCRA1o5Of/Hh3
 bSL5D/0WjjJt67VmSp16xhSyQgB0xJRmAu3KIvJPFilkspfyRsL1uDD6JopHm2QZE0NDX5FO5LW
 YO5i9djcvpAKsyEk5Ml26u9pK3c5ibEqe8yN4U57cW/TnbzxvvVCc5pMb+pUDgHhqhsmfnMlncW
 b9OMCMpkLF6b84GufiVgU9ILODIbC8u5MFTN+NQdamBtbV3OHJM3boCQY6NBkBKteyqOj09Nuc4
 VuofA+tLqvEsZ7ZSGSJAipEFBjxuYJWA/KhEFXJb0xyoGfT9eqjQjXpA3hlXz3xzLcVTKZuL1YE
 RvoQ8k3AJd7fidPLHXX9qXswdIP6rw8Oi6TaPQk/vj7QMy2ajVTtyU0eEe8nm0hDZ7J6fEoC008
 LMT8z2viLRCtluRkSeD6RCxaK4PyNH03RfEDY9HxRBlw9Re6H48gDG0GOmJQ1knX1TJAHMoByqc
 AauTNDvZwPsaXeKb7rKB6PaFYyey6qC1xKA6ZmWXQg7o0xKugbWJ4ijaula/c371j0heo0lK/J0
 ZVyhbHdFJE3l5IeN/T+ULag2mJ98BixKlVf+7V24/Z3d5btDmCeK78dpIgshlj+xxZ7RNrMoE9y
 GhYymvNjeDx4aKNxraMqD8fIezfUcw5qtkbw/lw58b+dnkZfxjVScpdVvyoX2ksePWLgjcuUjE/
 oXZ5sKXb3mQdZYw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[debian.org];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-238733-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 89AA74295FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

trim_newline() unconditionally dereferences s[len - 1] after computing
len = strnlen(s, maxlen). When the string is empty, len is 0 and the
expression underflows to s[(size_t)-1], reading (and potentially
writing) one byte before the buffer.

The two callers feed trim_newline() with the result of strscpy() from
configfs store callbacks (dev_name_store, userdatum_value_store).
configfs guarantees count >= 1 reaches the callback, but the byte
itself can be NUL: a userspace write(fd, "\0", 1) leaves the
destination empty after strscpy() and triggers the underflow. The OOB
write only fires if the adjacent byte happens to be '\n', so this is
not a security issue, but the access is undefined behaviour either way.

This pattern is commonly flagged by LLM-based code reviewers. While it
is not a security fix, the underlying access is undefined behaviour and
the change is small and self-contained, so it is a reasonable candidate
for the stable trees.

Guard the dereference on a non-zero length.

Fixes: ae001dc67907 ("net: netconsole: move newline trimming to function")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 3c9acd6e49e86..205384dab89a6 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -497,6 +497,8 @@ static void trim_newline(char *s, size_t maxlen)
 	size_t len;
 
 	len = strnlen(s, maxlen);
+	if (!len)
+		return;
 	if (s[len - 1] == '\n')
 		s[len - 1] = '\0';
 }

---
base-commit: c7275b05bc428c7373d97aa2da02d3a7fa6b9f66
change-id: 20260420-netcons_trim_newline-36f6ec3b9820

Best regards,
--  
Breno Leitao <leitao@debian.org>


