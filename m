Return-Path: <stable+bounces-233693-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNTQHGo41WlY3AcAu9opvQ
	(envelope-from <stable+bounces-233693-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 19:01:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F003B22A7
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 19:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30C1B300351F
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 17:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466B63CD8CB;
	Tue,  7 Apr 2026 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yXw5v3oT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085C833CEA8;
	Tue,  7 Apr 2026 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775581285; cv=none; b=VTAzU0GAyFDyWBb/Q7hCK7PE8ULS/8KWsblBbn0b6ybqGGhnh/5mvorjxElNkwMV+3CHmiI5rDhNr4tZHm7Wf+QCanlG2rI4XYnGg+LpyaxaGw/UgtpW3XzNq6Exkyk9Tc1EGKi7+S3L2aDwwlSWJrvTMsU5iqKRXtST6cemh7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775581285; c=relaxed/simple;
	bh=EzoFh6cp8KbdLy7uf+yYll9QvcsIqRxUwArJBxuF/uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7P7k9ueKEO/xMcBFBLNC+4RtZ2yBdHBaLUxiK46F5Hc5FUzveuJydFCjm5ZPuKwWyvGrTBMtfdRLoGZv2THyJO3lpr3qxsiGwqdQba6GcKi8d34fj8gfh1gaF0Dguclu+mbIhVEPmjjxWHexTmZG79Blwzik/ynwqVaVKunWUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yXw5v3oT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363DDC116C6;
	Tue,  7 Apr 2026 17:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775581284;
	bh=EzoFh6cp8KbdLy7uf+yYll9QvcsIqRxUwArJBxuF/uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yXw5v3oTGB65op552Woc03TyrFRdUggNq180k9KVDHVtO6YU7cFVLXORUBbJ+DTrm
	 xWcFpReFK4/o5z6u6XObQIjtAxbjHwyT92OW/71PDRxV+m8mNMLn+gmNQWSyCdwAPG
	 DwjAGw9FYVcrm2iMCzkc8h/gEceQeud4Yei+ad5Y=
Date: Tue, 7 Apr 2026 19:01:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	netdev@vger.kernel.org, Igor Ushakov <sysroot314@gmail.com>
Subject: Re: [PATCH v3 net] af_unix: Give up GC if MSG_PEEK intervened.
Message-ID: <2026040752-sequence-bladder-dd8e@gregkh>
References: <20260311054043.1231316-1-kuniyu@google.com>
 <20260407155827.GA1993342@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407155827.GA1993342@google.com>
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
	TAGGED_FROM(0.00)[bounces-233693-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,davemloft.net,kernel.org,redhat.com,gmail.com,linuxfoundation.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35F003B22A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 04:58:27PM +0100, Lee Jones wrote:
> INTENTIONAL TOP POST
> 
> I note that this was not sent to Stable, but it should be included please.

As mentioned on chat, It already is, if you want it backported further,
can you please provide working backports?

thanks,

greg k-h

