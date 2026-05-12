Return-Path: <stable+bounces-245503-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCZPMnwkA2oF1AEAu9opvQ
	(envelope-from <stable+bounces-245503-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:00:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7962F52096A
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F1EA3058E45
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 12:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE713A2E35;
	Tue, 12 May 2026 12:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eHY9xBke"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7A239732D
	for <stable@vger.kernel.org>; Tue, 12 May 2026 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589976; cv=none; b=SS+ECXpBmAjF8K52ycmP61ebpuCa1ToCb2ktn5VqqE/JHCrYjfb6kSZjLSH8eCCeoRcYWperpkTR+UFOKiq1EiQLHB/EzYelIEamEJyjl97bcad/59iEaYtSnxrwOKlgUMVKfPmGlvSSop3s6ymZdbIXe8X20Ai+qWGqEyjUlE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589976; c=relaxed/simple;
	bh=YNXAQ5XbhZpUQKKm1/f8jJTHgISGrTLErAlc0WbuhBQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Yru6oU96OIQehhdF0D02Mlf7PU3GB/DWSxQZR90XQE2HQ9xSrk3D6e44OEKjBeZM9uqqgg22gyGr8Mjewjw28OnPDpTb9+qE6oIygCZe6wiENi/6CmiAQSOuokaNBKm6auC+rif1HoPvjS0m0niZ6bclucC+yXn1Swhi99E0zzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eHY9xBke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB574C2BCF7;
	Tue, 12 May 2026 12:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778589975;
	bh=YNXAQ5XbhZpUQKKm1/f8jJTHgISGrTLErAlc0WbuhBQ=;
	h=Subject:To:Cc:From:Date:From;
	b=eHY9xBkezFJEwKkLQjATcuz0QyaF83QgXaZTiWIc81UODGkoX4l7Pp3BKnuFaA3g5
	 7tJyS93RW6FeVDCIkpwYTrY/VGBf6lTE84kRd8DqcMY/szygeOVdX0Pzy9ed28SLfT
	 reULQ9aBG45pWLEsLDwSANYZfTNEPCc0irLE9RXU=
Subject: FAILED: patch "[PATCH] rust: allow `clippy::collapsible_match` globally" failed to apply to 6.12-stable tree
To: ojeda@kernel.org,gary@garyguo.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 14:44:00 +0200
Message-ID: <2026051200-blurred-frugality-a412@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7962F52096A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245503-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RSPAMD_URIBL_FAIL(0.00)[garyguo.net:query timed out];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,garyguo.net:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 838d852da8503372f3a1779bfbd1ccb93153ab4e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051200-blurred-frugality-a412@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 838d852da8503372f3a1779bfbd1ccb93153ab4e Mon Sep 17 00:00:00 2001
From: Miguel Ojeda <ojeda@kernel.org>
Date: Sun, 26 Apr 2026 16:42:00 +0200
Subject: [PATCH] rust: allow `clippy::collapsible_match` globally

The `clippy::collapsible_match` lint [1] can make code harder to read
in certain cases [2], e.g.

      CLIPPY P rust/libmacros.so - due to command line change
    warning: this `if` can be collapsed into the outer `match`
      --> rust/pin-init/internal/src/helpers.rs:91:17
       |
    91 | /                 if nesting == 1 {
    92 | |                     impl_generics.push(tt.clone());
    93 | |                     impl_generics.push(tt);
    94 | |                     skip_until_comma = false;
    95 | |                 }
       | |_________________^
       |
       = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#collapsible_match
       = note: `-W clippy::collapsible-match` implied by `-W clippy::all`
       = help: to override `-W clippy::all` add `#[allow(clippy::collapsible_match)]`
    help: collapse nested if block
       |
    90 ~             TokenTree::Punct(p) if skip_until_comma && p.as_char() == ','
    91 ~                 && nesting == 1 => {
    92 |                     impl_generics.push(tt.clone());
    93 |                     impl_generics.push(tt);
    94 |                     skip_until_comma = false;
    95 ~                 }
       |

The lint does not have much upside -- when the suggestion may be a good
one, it would still read fine when nested anyway. And it is the kind of
lint that may easily bias people to just apply the suggestion instead
of allowing it.

[ In addition, as Gary points out [3], the suggestion is also wrong [4] and
  in the process of being fixed [5], possibly for Rust 1.97.0:

  Link: https://lore.kernel.org/rust-for-linux/DI3YV94TH9I3.1SOHW51552497@garyguo.net/ [3]
  Link: https://github.com/rust-lang/rust-clippy/issues/16875 [4]
  Link: https://github.com/rust-lang/rust-clippy/pull/16878 [5]

    - Miguel ]

Thus just let developers decide on their own.

Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
Link: https://rust-lang.github.io/rust-clippy/master/index.html#collapsible_match [1]
Link: https://lore.kernel.org/rust-for-linux/CANiq72nWYJna_hdFxjQCQZK6yJBrr1Mb86iKavivV0U0BgufeA@mail.gmail.com/ [2]
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://patch.msgid.link/20260426144201.227108-1-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

diff --git a/Makefile b/Makefile
index e27c91ea56fc..621d84aa4700 100644
--- a/Makefile
+++ b/Makefile
@@ -486,6 +486,7 @@ export rust_common_flags := --edition=2021 \
 			    -Wclippy::as_ptr_cast_mut \
 			    -Wclippy::as_underscore \
 			    -Wclippy::cast_lossless \
+			    -Aclippy::collapsible_match \
 			    -Wclippy::ignored_unit_patterns \
 			    -Aclippy::incompatible_msrv \
 			    -Wclippy::mut_mut \


