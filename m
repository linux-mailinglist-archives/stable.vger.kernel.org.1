Return-Path: <stable+bounces-245504-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NqaAsgvA2qN1QEAu9opvQ
	(envelope-from <stable+bounces-245504-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:48:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCFA5219CC
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F47F30DFCCD
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 12:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF76372047;
	Tue, 12 May 2026 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kmx5stCq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B963911D3
	for <stable@vger.kernel.org>; Tue, 12 May 2026 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589979; cv=none; b=OdcA6cL0H+gYy3nUU/ZmoWnONYy7vAHAl94+5/d3KGTSMm4JMkkvPOZG8Cm3ZSzU5uF9JmT0WgRkacWvbb1CUgX77p1wZxZ0WuOKNREFj/d3EjU8wsTo6yCDqQyuriY8FfijNWXOj9Kz4Hu2AbsitR8C3qv96qKBNJ77EvMIWc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589979; c=relaxed/simple;
	bh=veSKUSwKfwBcjRSKEYClz3LSwU/uQcMApITIn3blKL0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=govj8sS+Ex15CRBZ8zPuAndDt82sOb4duBP3AuwqBHPZb/hdw1asMpudF07OYs3YRCZRRgIsKci2DM4klM3RPx1vvMqKr4wT35J8ZYOWArGGuQZZ4p+5mv6UAhq6rTK+1rGvvZLXcbAz5sEQGW1sfEyzEPPsZQ6rZrj3XgxulT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kmx5stCq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA434C2BCB0;
	Tue, 12 May 2026 12:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778589979;
	bh=veSKUSwKfwBcjRSKEYClz3LSwU/uQcMApITIn3blKL0=;
	h=Subject:To:Cc:From:Date:From;
	b=kmx5stCq3Bo0xOJl1TX21eTS23nDkGa+63JttLvD7JN+cYg1gMA9tSZ3SwSY3Jchy
	 8sisK5WsShVSBFOD1G0mVSHBbOtP7y+wt+XWQyOZJBt4erW/5kpS3D9UYTV800IvZA
	 rVBszVUfC4iXc2lh4lP+IXVaR0xXSAU2WU3cwVvo=
Subject: FAILED: patch "[PATCH] rust: allow `clippy::collapsible_if` globally" failed to apply to 6.12-stable tree
To: ojeda@kernel.org,gary@garyguo.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 14:44:10 +0200
Message-ID: <2026051210-epic-emblaze-b4eb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5BCFA5219CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245504-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,gregkh:email,rust-lang.github.io:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,garyguo.net:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 2adc8664018c1cc595c7c0c98474a33c7fe32a85
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051210-epic-emblaze-b4eb@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2adc8664018c1cc595c7c0c98474a33c7fe32a85 Mon Sep 17 00:00:00 2001
From: Miguel Ojeda <ojeda@kernel.org>
Date: Sun, 26 Apr 2026 16:42:01 +0200
Subject: [PATCH] rust: allow `clippy::collapsible_if` globally

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

diff --git a/Makefile b/Makefile
index 621d84aa4700..28f4ae452441 100644
--- a/Makefile
+++ b/Makefile
@@ -486,6 +486,7 @@ export rust_common_flags := --edition=2021 \
 			    -Wclippy::as_ptr_cast_mut \
 			    -Wclippy::as_underscore \
 			    -Wclippy::cast_lossless \
+			    -Aclippy::collapsible_if \
 			    -Aclippy::collapsible_match \
 			    -Wclippy::ignored_unit_patterns \
 			    -Aclippy::incompatible_msrv \
diff --git a/drivers/android/binder/range_alloc/array.rs b/drivers/android/binder/range_alloc/array.rs
index ada1d1b4302e..081d19b09d4b 100644
--- a/drivers/android/binder/range_alloc/array.rs
+++ b/drivers/android/binder/range_alloc/array.rs
@@ -204,7 +204,6 @@ pub(crate) fn reservation_abort(&mut self, offset: usize) -> Result<FreedRange>
         // caller will mark them as unused, which means that they can be freed if the system comes
         // under memory pressure.
         let mut freed_range = FreedRange::interior_pages(offset, size);
-        #[expect(clippy::collapsible_if)] // reads better like this
         if offset % PAGE_SIZE != 0 {
             if i == 0 || self.ranges[i - 1].endpoint() <= (offset & PAGE_MASK) {
                 freed_range.start_page_idx -= 1;


