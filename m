Return-Path: <stable+bounces-230070-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LY/JxFDwmmCagQAu9opvQ
	(envelope-from <stable+bounces-230070-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 08:53:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF92304376
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 08:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 873C530FB120
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 07:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32FF34A77D;
	Tue, 24 Mar 2026 07:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KpbWwdJ2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BDB3358DA;
	Tue, 24 Mar 2026 07:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774338364; cv=none; b=l4kw7RMISL5oAq3dneosDrhd4VPjOuZg02WhZ7c8pgNvX53VjvWLgPqKijUVo7bCB4CKohYpVjS9PlQCT1cpZ96ijsL+vcyEmETaKXrYX5RtO3fHWOlHFg1IsbiDoL132pw93STdCjGr2HEeiAOglYyZjZI/LMFuB43xVPgROnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774338364; c=relaxed/simple;
	bh=nkJcWKY/eHSu+yAwuU6uelRb+wvZBwy5dbyA9cxrKT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bp5p1SohtVldDQHDP/zRyja/9g9fpBtatCxuuAbDQhwBXRZDKQqGaqzUeD7kCwUGiT/99Wr9fbTg3yKDp4mo+XcpvNjWXNC8pAAfW99YPAwlhZ5MF2fGcFMrIAP3QKU3LDSg88gEh5nu93UDCc+NWGweNQXuaUKuTb3odPVbpgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KpbWwdJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58E4C19424;
	Tue, 24 Mar 2026 07:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774338363;
	bh=nkJcWKY/eHSu+yAwuU6uelRb+wvZBwy5dbyA9cxrKT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KpbWwdJ2SUuquR5tDyy23iAinDcUwJ759YvYab9+0h839uhOLqCHJFszI7SqybC/Z
	 HyBayWhrTdKV4PfSzjsVl0ZVG07sl4Szsat7DWtlhSQPR1NaJd+1yYmAZX44xnD8ci
	 zwyztviHLqhjml8pIdcjEm+Il1wF9ByJX7RstQ3Y=
Date: Tue, 24 Mar 2026 08:45:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "1016331059@qq.com" <1016331059@qq.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"mark@fasheh.com" <mark@fasheh.com>,
	"jlbec@evilplan.org" <jlbec@evilplan.org>,
	"joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
	"syzbot+c6104ecfe56e0fd6b616@syzkaller.appspotmail.com" <syzbot+c6104ecfe56e0fd6b616@syzkaller.appspotmail.com>
Subject: Re: [PATCH 5.15.y] ocfs2: fix shift-out-of-bounds UBSAN bug in
 ocfs2_verify_volume
Message-ID: <2026032416-dispersal-henna-f21d@gregkh>
References: <tencent_BA29A271C331E1BB2072C04E5D55C1B90405@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_BA29A271C331E1BB2072C04E5D55C1B90405@qq.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230070-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[qq.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,c6104ecfe56e0fd6b616];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,qq.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FF92304376
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 07:04:58AM +0000, 1016331059@qq.com wrote:
> This patch is a backport to stable 5.15.y of upstream commit
> 7f86b2942791012ac7b4c481d1f84a58fd2fbcfc
> ("ocfs2: fix shift-out-of-bounds UBSAN bug in ocfs2_verify_volume()").

This was attached, and could not be applied directly.  Please submit the
patch inline.

thanks,

greg k-h

