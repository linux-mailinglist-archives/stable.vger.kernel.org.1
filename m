Return-Path: <stable+bounces-271515-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m0qzGzmcRmpqaAsAu9opvQ
	(envelope-from <stable+bounces-271515-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:13:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EC36FB240
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:13:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=FrxPUdvJ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271515-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271515-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B6CF30A7F3E
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 17:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031123093DD;
	Thu,  2 Jul 2026 17:02:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A05433E87;
	Thu,  2 Jul 2026 17:02:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011744; cv=none; b=dJBL7Vf+66B8i+MGvtqOfy/o45IKRfCibJUBHfj2zpeD0g9sWHcPwpDUm26B8yOwfwdpBkWSCI150DXow+WPgAFalkAk9Sniql8rMLEsshTRPJ3oAJbpomzzhweI8gcjim2JrzCZWiYdr0bBWaZSPzAZwIoTFnOFh4V59DYKT8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011744; c=relaxed/simple;
	bh=mH8Rj3qNKaNfpJSKsqW06bXVo9qQEwOw3oiAG7a1suY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YWIwmaOzArbhEfuYk6QyfslEf68D33dki/a4RqTqzFDBwJc3apf6E8qjnVr4jKTCmxlUPoPVq0mmUl9s62iDl+frqYCPA/Azppa5+yC+jIK0PXxf1egLwLbriXhJxogxB7cYLF6sXKOCXLmJbpH+BIvtJDpA2Fdyyc3/04/HmeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FrxPUdvJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D038B1F000E9;
	Thu,  2 Jul 2026 17:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011743;
	bh=QUa32pOc3hnNQFVbe07hKMuaZ5M58CLND3IyulgkEmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FrxPUdvJJXIbXfwV3C3xToG0eRShnWI4J9VclTy/wvGHbA3IrLJvigWzUzjSITSbv
	 ilUwon7vQlR9jbX0IvWog/GnFZpgQ18nC7EgACqLoQ/jJfPrQ20ihpipdSX+oTEBcm
	 xhcO/iAGe0G+FWzqf8Y7CF6znxsK+wUTSqmbAoEw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	NeilBrown <neil@brown.name>,
	Igor Raits <igor.raits@gmail.com>,
	Anna Schumaker <anna.schumaker@hammerspace.com>,
	=?UTF-8?q?Jan=20=C4=8C=C3=ADpa?= <jan.cipa@gooddata.com>
Subject: [PATCH 7.1 116/120] NFSv4: clear exception state on successful mkdir retry
Date: Thu,  2 Jul 2026 18:21:52 +0200
Message-ID: <20260702155115.357779473@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.964534952@linuxfoundation.org>
References: <20260702155112.964534952@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271515-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,brown.name,gmail.com,hammerspace.com,gooddata.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:neil@brown.name,m:igor.raits@gmail.com,m:anna.schumaker@hammerspace.com,m:jan.cipa@gooddata.com,m:igorraits@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:email,hammerspace.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,gooddata.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12EC36FB240

7.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Igor Raits <igor.raits@gmail.com>

commit 238e9b51aa29f48b6243212a3b75c8e48d6b96fd upstream.

After a server returns NFS4ERR_DELAY for an NFSv4 CREATE issued by
mkdir(2), the client correctly waits and retries.  When the retry
succeeds, however, mkdir(2) can still surface -EEXIST to userspace
even though the directory was just created on the server.

Reproducer (random 16-hex names so collisions are not the cause)
against an in-kernel Linux nfsd; reproduces under both NFSv4.0 and
NFSv4.2:

  N=2000000; base=/var/gdc/export
  for ((i=1; i<=N; i++)); do
      d=$base/$(openssl rand -hex 8)
      mkdir "$d" 2>/dev/null || echo "$(date +%T) failed loop=$i $d"
      rmdir "$d" 2>/dev/null
  done

Failures cluster at the cadence at which the server-side auth/export
cache refresh path causes nfsd to return NFS4ERR_DELAY for CREATE.

A wire trace of one failure (the three CREATE RPCs all come from a
single mkdir(2), generated by the do-while in nfs4_proc_mkdir()):

  client -> server  CREATE name=...  -> NFS4ERR_DELAY
  ~100 ms later
  client -> server  CREATE name=...  -> NFS4_OK         (dir created)
  ~80 us later
  client -> server  CREATE name=...  -> NFS4ERR_EXIST   (correct)

Since commit dd862da61e91 ("nfs: fix incorrect handling of large-number
NFS errors in nfs4_do_mkdir()"), nfs4_handle_exception() is called only
when _nfs4_proc_mkdir() returned an error.  That gate breaks retry-state
hygiene: nfs4_do_handle_exception() resets exception.{delay,recovering,
retry} to 0 on entry, so calling it on success is what previously
cleared the retry flag set by the preceding NFS4ERR_DELAY iteration.
With the gate in place, exception.retry stays at 1 after the successful
retry, the loop runs once more, and the resulting CREATE for an
already-created name yields NFS4ERR_EXIST -> -EEXIST to userspace.

Drop the conditional and call nfs4_handle_exception() unconditionally,
matching every other do-while in fs/nfs/nfs4proc.c (nfs4_proc_symlink(),
nfs4_proc_link(), etc.).  The dentry/status separation introduced by
that commit is preserved.

Fixes: dd862da61e91 ("nfs: fix incorrect handling of large-number NFS errors in nfs4_do_mkdir()")
Reported-and-tested-by: Jan Čípa <jan.cipa@gooddata.com>
Closes: https://lore.kernel.org/linux-nfs/CA+9S74hSp_tJu2Ffe2BPNC2T25gfkhgjjDkdgSsF5c2rnJq_wA@mail.gmail.com/
Reviewed-by: NeilBrown <neil@brown.name>
Cc: stable@vger.kernel.org
Signed-off-by: Igor Raits <igor.raits@gmail.com>
Signed-off-by: Anna Schumaker <anna.schumaker@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/nfs4proc.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5302,10 +5302,9 @@ static struct dentry *nfs4_proc_mkdir(st
 	do {
 		alias = _nfs4_proc_mkdir(dir, dentry, sattr, label, &err);
 		trace_nfs4_mkdir(dir, &dentry->d_name, err);
+		err = nfs4_handle_exception(NFS_SERVER(dir), err, &exception);
 		if (err)
-			alias = ERR_PTR(nfs4_handle_exception(NFS_SERVER(dir),
-							      err,
-							      &exception));
+			alias = ERR_PTR(err);
 	} while (exception.retry);
 	nfs4_label_release_security(label);
 



