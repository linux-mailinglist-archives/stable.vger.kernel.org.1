Return-Path: <stable+bounces-227048-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGcDM8CZumnaZQIAu9opvQ
	(envelope-from <stable+bounces-227048-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 13:25:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3AF2BB6C0
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 13:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32DF13002E40
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A61E3A9DB9;
	Wed, 18 Mar 2026 12:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p7A++aKC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E31139C625
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773836706; cv=none; b=WUHTcHUXyS+4cordESPQAEVuxP3YwxbZSLMxr7Qe26U2Gj0lYzks80W4Qs6vukWWq8YRB5t7M9R0O888Q1NF4bd+PpsEjLSEKSHRmLZzgdQcODVYAquCl/XM+NoRAah+6c4XxOkuXdy7mMZWXfQAzKg9XS0NWJO5NDnULsVKqwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773836706; c=relaxed/simple;
	bh=l7k327fTGsdMZW1pGLnpw9RYKkb2ONZHZ8njtfwCFEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwyqhJ4Z4lvLE9Kx/NxP1zglPwXhAlTV9GRCco1qbO9Hp+mBvOD8iIHqIhC2Yyiaviz1LcqMn8dxyRXcF6ZurC1GdewU+XBM4a8ZC4yNth19vJr3ZumDOndbs+gQ4rL76uEdYOAxRLJfEnKJSErzfnNltKM0ZMoRD7sH9zgP/Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p7A++aKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31655C19421;
	Wed, 18 Mar 2026 12:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773836705;
	bh=l7k327fTGsdMZW1pGLnpw9RYKkb2ONZHZ8njtfwCFEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p7A++aKCYkH6ONAA4zvGUCqyIV2dibOhm9J+cLurKung8PJcQRpxmbygrZzHLs9YM
	 30KBYW1jG5/CCer+Wb6OfsQfqC+6N4KDosLIgcFeLiAnAC4++2aTuqigR2B15/PAJj
	 VCiw8Zxh22Qvbq/glFb66O4hYbVowyvzBYuohjK8=
Date: Wed, 18 Mar 2026 13:25:01 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Lin, Shuicheng" <shuicheng.lin@intel.com>
Cc: "Brost, Matthew" <matthew.brost@intel.com>,
	"Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] drm/xe/sync: Cleanup partially
 initialized sync on parse" failed to apply to 6.12-stable tree
Message-ID: <2026031851-glamour-unusual-8513@gregkh>
References: <2026031732-size-unfasten-2bf3@gregkh>
 <DM4PR11MB5456BBF097AD0D1312B7D337EA41A@DM4PR11MB5456.namprd11.prod.outlook.com>
 <2026031748-huskiness-autistic-5186@gregkh>
 <DM4PR11MB5456067D5FE7F51042296C41EA41A@DM4PR11MB5456.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM4PR11MB5456067D5FE7F51042296C41EA41A@DM4PR11MB5456.namprd11.prod.outlook.com>
X-Spamd-Result: default: False [3.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	FROM_DN_EQ_ADDR(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227048-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C3AF2BB6C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 05:10:53PM +0000, Lin, Shuicheng wrote:
> On Tue, Mar 17, 2026 9:32 AM greg k-h wrote:
> > On Tue, Mar 17, 2026 at 04:27:46PM +0000, Lin, Shuicheng wrote:
> > > On Tue, Mar 17, 2026 4:48 AM gregkh wrote:
> > > > The patch below does not apply to the 6.12-stable tree.
> > > > If someone wants it applied there, or to any other stable or
> > > > longterm tree, then please email the backport, including the
> > > > original git commit id to <stable@vger.kernel.org>.
> > > >
> > > > To reproduce the conflict and resubmit, you may use the following
> > commands:
> > > >
> > > > git fetch
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/
> > > > linux-6.12.y git checkout FETCH_HEAD git cherry-pick -x
> > > > 1bfd7575092420ba5a0b944953c95b74a5646ff8
> > > > # <resolve conflicts, build, test, etc.> git commit -s git
> > > > send-email --to '<stable@vger.kernel.org>' --in-reply-to
> > > > '2026031732-size-unfasten- 2bf3@gregkh' --subject-prefix 'PATCH 6.12.y'
> > HEAD^..
> > >
> > > I cannot reproduce the failure with upper cmd.
> > > The patch could be applied successfully without conflict.
> > > Anyway, I follow the instructions re-send the patch.
> > > Let me know if it still has issue.
> > 
> > Try building it after it is applied and notice how it breaks the build :(
> 
> I tried to do it, and it could build successfully.
> I checked the code and cannot find what will cause the build failure.
> Could you please share me the failure signature?

  CC [M]  drivers/gpu/drm/xe/xe_sync.o
drivers/gpu/drm/xe/xe_sync.c: In function ‘xe_sync_entry_parse’:
drivers/gpu/drm/xe/xe_sync.c:182:33: error: label ‘free_sync’ used but not defined
  182 |                                 goto free_sync;
      |                                 ^~~~
drivers/gpu/drm/xe/xe_sync.c: In function ‘xe_sync_entry_add_deps’:
drivers/gpu/drm/xe/xe_sync.c:228:16: error: ‘err’ undeclared (first use in this function)
  228 |         return err;
      |                ^~~
drivers/gpu/drm/xe/xe_sync.c:228:16: note: each undeclared identifier is reported only once for each function it appears in
drivers/gpu/drm/xe/xe_sync.c:226:1: error: label ‘free_sync’ defined but not used [-Werror=unused-label]
  226 | free_sync:
      | ^~~~~~~~~
cc1: all warnings being treated as errors



