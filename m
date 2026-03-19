Return-Path: <stable+bounces-227252-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOQrGVnJu2leoQIAu9opvQ
	(envelope-from <stable+bounces-227252-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 11:00:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 028022C9300
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 11:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EF50325D5F0
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 09:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C8C377567;
	Thu, 19 Mar 2026 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O+GIjHNy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD76376BCC
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773913718; cv=none; b=WmIOFVBjZiUTWozIqnFbKuCERs8EuZ9gdLBaXwJlPH/VppHrE+R6VR4YjT8i7Zr58bdwonIh++yJ5Eqbi1Z+dkjDnOgJ/cFPdP+lkaa5OCkaynRkDFLxghEWJ6d+sCW64wzrFH8KsLqolwI/epB7n1DDhKuG6vK223cYp7bLMrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773913718; c=relaxed/simple;
	bh=cTjDn07bhiZYnY0791588heZa+B5zkZmp9NZrT+nyOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DappxT21mkFwXqZCw1CJqbD6oIQOSXCJBfnM6lL9wsJKE2iKiBd+gUEGjTYYWkk5+gMxb0TU6oWAXuTH6TnCwu31Y/ppiTDrIjlpAJdIpzuyisPJTRj8o68k+e5g14nTj1lbafxEhpeRZsteDLIib517knkoG17j5hnUNDfngRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O+GIjHNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2E7C19424;
	Thu, 19 Mar 2026 09:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773913718;
	bh=cTjDn07bhiZYnY0791588heZa+B5zkZmp9NZrT+nyOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O+GIjHNyQEpPcLLykQ6exY3l1QMQawXd8vbdzH5ZX7KFGu+eXL86H3rI0ZU5HEK5W
	 wzWTGT6PZCjMlIzp7GeJKA8A4gY5Ol70GvZxunngtX2HJle77Z/pxahWHKROnToDUi
	 3xZyNBG+kxXu2a+okXUymJUodKxOLSq684wW2Ei8=
Date: Thu, 19 Mar 2026 10:48:33 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Lin, Shuicheng" <shuicheng.lin@intel.com>
Cc: "Brost, Matthew" <matthew.brost@intel.com>,
	"Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] drm/xe/sync: Cleanup partially
 initialized sync on parse" failed to apply to 6.12-stable tree
Message-ID: <2026031924-headache-catnip-cfd6@gregkh>
References: <2026031732-size-unfasten-2bf3@gregkh>
 <DM4PR11MB5456BBF097AD0D1312B7D337EA41A@DM4PR11MB5456.namprd11.prod.outlook.com>
 <2026031748-huskiness-autistic-5186@gregkh>
 <DM4PR11MB5456067D5FE7F51042296C41EA41A@DM4PR11MB5456.namprd11.prod.outlook.com>
 <2026031851-glamour-unusual-8513@gregkh>
 <DM4PR11MB5456118C166481BEABF3CF33EA4EA@DM4PR11MB5456.namprd11.prod.outlook.com>
 <2026031828-dyslexic-retract-a423@gregkh>
 <DM4PR11MB54564E029B910AA49F92397CEA4EA@DM4PR11MB5456.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM4PR11MB54564E029B910AA49F92397CEA4EA@DM4PR11MB5456.namprd11.prod.outlook.com>
X-Spamd-Result: default: False [3.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	FROM_DN_EQ_ADDR(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227252-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[linuxfoundation.org:query timed out];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[2026031732-size-unfasten-2bf3.gregkh:query timed out];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.954];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email]
X-Rspamd-Queue-Id: 028022C9300
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 05:20:05PM +0000, Lin, Shuicheng wrote:
> On Wed, Mar 18, 2026 9:59 AM greg k-h wrote:
> > On Wed, Mar 18, 2026 at 04:26:44PM +0000, Lin, Shuicheng wrote:
> > > On Wed, Mar 18, 2026 5:25 AM gregkh wrote:
> > > > On Tue, Mar 17, 2026 at 05:10:53PM +0000, Lin, Shuicheng wrote:
> > > > > On Tue, Mar 17, 2026 9:32 AM greg k-h wrote:
> > > > > > On Tue, Mar 17, 2026 at 04:27:46PM +0000, Lin, Shuicheng wrote:
> > > > > > > On Tue, Mar 17, 2026 4:48 AM gregkh wrote:
> > > > > > > > The patch below does not apply to the 6.12-stable tree.
> > > > > > > > If someone wants it applied there, or to any other stable or
> > > > > > > > longterm tree, then please email the backport, including the
> > > > > > > > original git commit id to <stable@vger.kernel.org>.
> > > > > > > >
> > > > > > > > To reproduce the conflict and resubmit, you may use the
> > > > > > > > following
> > > > > > commands:
> > > > > > > >
> > > > > > > > git fetch
> > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux
> > > > > > > > .git / linux-6.12.y git checkout FETCH_HEAD git cherry-pick
> > > > > > > > -x
> > > > > > > > 1bfd7575092420ba5a0b944953c95b74a5646ff8
> > > > > > > > # <resolve conflicts, build, test, etc.> git commit -s git
> > > > > > > > send-email --to '<stable@vger.kernel.org>' --in-reply-to
> > > > > > > > '2026031732-size-unfasten- 2bf3@gregkh' --subject-prefix
> > > > > > > > 'PATCH
> > > > 6.12.y'
> > > > > > HEAD^..
> > > > > > >
> > > > > > > I cannot reproduce the failure with upper cmd.
> > > > > > > The patch could be applied successfully without conflict.
> > > > > > > Anyway, I follow the instructions re-send the patch.
> > > > > > > Let me know if it still has issue.
> > > > > >
> > > > > > Try building it after it is applied and notice how it breaks the
> > > > > > build :(
> > > > >
> > > > > I tried to do it, and it could build successfully.
> > > > > I checked the code and cannot find what will cause the build failure.
> > > > > Could you please share me the failure signature?
> > > >
> > > >   CC [M]  drivers/gpu/drm/xe/xe_sync.o
> > > > drivers/gpu/drm/xe/xe_sync.c: In function ‘xe_sync_entry_parse’:
> > > > drivers/gpu/drm/xe/xe_sync.c:182:33: error: label ‘free_sync’ used
> > > > but not defined
> > > >   182 |                                 goto free_sync;
> > > >       |                                 ^~~~
> > >
> > > Thanks for the log.
> > > It seems the patch is not applied correctly and cause the build failure.
> > > For the original patch 1bfd75750924 ("drm/xe/sync: Cleanup partially
> > > initialized sync on parse failure"), all the change is within function
> > xe_sync_entry_parse().
> > > This "free_sync" label is added at the end of xe_sync_entry_parse(), and
> > some error path use goto to jump to this label.
> > >
> > > For this and below err, it seems the last part of this patch is applied to
> > function xe_sync_entry_add_deps(), which is the function after
> > xe_sync_entry_parse().
> > > The err should be due to "free_sync" label is added to function
> > xe_sync_entry_add_deps() instead of xe_sync_entry_parse().
> > > Could you please help me confirm it?
> > 
> > It's best if you can send a properly backported patch for us to apply.
> 
> Yes. I did re-send the patch yesterday following below cmd. The problem is that I cannot reproduce the failure.
> "
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y 
> git checkout FETCH_HEAD 
> git cherry-pick -x 1bfd7575092420ba5a0b944953c95b74a5646ff8
> git commit -s --amend
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031732-size-unfasten-2bf3@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> "
> There is no conflict and I could pass build.
> Not sure what is the difference and lead to the issue.
> Could you please have a try again with the patch I sent yesterday?

Your patch applied properly, thanks.

greg k-h

