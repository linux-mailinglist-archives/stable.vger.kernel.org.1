Return-Path: <stable+bounces-247970-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KM74BkdEB2oCvAIAu9opvQ
	(envelope-from <stable+bounces-247970-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:05:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DBD552A81
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 27772304A9C8
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA83A3FF1DA;
	Fri, 15 May 2026 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w+7+s3VD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9DD30566D;
	Fri, 15 May 2026 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860539; cv=none; b=F8BMbqA00hp6jXEY+EyPdT+3Lf2TDzfYoZzAX2wzjv0M6IIRLJnlzHSqqBb3R+koboJfOE8BVnXT9Up2ppHcIafrVbX77wS1J1KOZ5lMYf4HNxXL5TAc4mvK5kew4ig+YzcTMDse0mAZI4yRiFqQnOaimiEGCyOf+ySLhp0+u/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860539; c=relaxed/simple;
	bh=a1xU8UUVFiM7YIgwdI2AZt1Avh3VCHTIM+DmHThbLvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YE3PPVNp1jZravugcv31EM0SAogg8R64fP2jj4Me2YIBc/U3NM8W0hGQNuAntNXHaYn9x5075QslQIAiSCXZlrYVFbOTWxpWFhbNo86d/PsMP0tBmkAJsPFbjhB4QDtFfXUscuUY3iH1+lHSl/hjUikmRn3vSJQG1tyA692Sx/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w+7+s3VD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3967C2BCB3;
	Fri, 15 May 2026 15:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860539;
	bh=a1xU8UUVFiM7YIgwdI2AZt1Avh3VCHTIM+DmHThbLvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w+7+s3VDKn2GzlOcRN95QH2K8+BcxFDl3Yzefxs5NEk8Kgr1FlikKp78RbGLT6K9U
	 BpiNyVEC+hawA3la3zwDY8ITcnatWGWXwQMqhAPjVtbxMzUpN3hA+NCKs+x69Xat0j
	 5bea7v2UwvPE/o5XFKR/qpDrt9YRbNbuUOGC2R6I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.12 128/144] rust: allow `clippy::collapsible_if` globally
Date: Fri, 15 May 2026 17:49:14 +0200
Message-ID: <20260515154656.479574239@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154653.469907118@linuxfoundation.org>
References: <20260515154653.469907118@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 36DBD552A81
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-247970-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,rust-lang.github.io:url]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miguel Ojeda <ojeda@kernel.org>

commit 2adc8664018c1cc595c7c0c98474a33c7fe32a85 upstream.

Similar to `clippy::collapsible_match` (globally allowed in the previous
commit), the `clippy::collapsible_if` lint [1] can make code harder to
read in certain cases.

Thus just let developers decide on their own.

In addition, remove the existing `expect` we had.

Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
Suggested-by: Gary Guo <gary@garyguo.net>
Link: https://lore.kernel.org/rust-for-linux/DGROP5CHU1QZ.1OKJRAUZXE9WC@garyguo.net/
Link: https://rust-lang.github.io/rust-clippy/master/index.html#collapsible_if [1]
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://patch.msgid.link/20260426144201.227108-2-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile |    1 +
 1 file changed, 1 insertion(+)

--- a/Makefile
+++ b/Makefile
@@ -453,6 +453,7 @@ export rust_common_flags := --edition=20
 			    -Wrust_2018_idioms \
 			    -Wunreachable_pub \
 			    -Wclippy::all \
+			    -Aclippy::collapsible_if \
 			    -Aclippy::collapsible_match \
 			    -Wclippy::ignored_unit_patterns \
 			    -Wclippy::mut_mut \



