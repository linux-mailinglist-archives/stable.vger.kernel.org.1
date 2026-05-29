Return-Path: <stable+bounces-256461-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKEfBUn7GGrapQgAu9opvQ
	(envelope-from <stable+bounces-256461-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 04:34:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 898415FC6A0
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 04:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A815C30309AB
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 02:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C76A3644C4;
	Fri, 29 May 2026 02:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ou1jzUI/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D522DEA89;
	Fri, 29 May 2026 02:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780022082; cv=none; b=GWN83jphq4M6Kfeq3an9B2LLos+i5My8ig2oPQZCwcQmfpcX9e1dyDrBCCGplbzWxuzM/ZntzmCJe4yYZniClgjqQL+rqhRyzFtmUx0jX2mdr+XpOFwlglFBTiFkdSA5+H4z/n2eI/ecm98L0dJlXWeNA2CMSXovXQzJI82irPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780022082; c=relaxed/simple;
	bh=W/6fTn2fiWbzOsj1NzyPspeYDJWY0xVzhnjsb7JjLvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DghASvM/YQxLYxct/NBYYRoPGx6raWf5BHOdebn0JxiGFyAfoKnRbiAxPIunX6rupmJ8r8O4GSFmqlf5QkisgEmhf5nzQvZqkSyYxiHARtnHRVAbq0RQzYnk5VfOzQmW5ZIuh/FKFBY6l2gmE86uOP9ONswcvbCRhBlhK+rED/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ou1jzUI/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF9C1F000E9;
	Fri, 29 May 2026 02:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780022080;
	bh=/QQiyp5bXy/5aTRYF99XYzeidLDyFywwRSAUO5S2v/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ou1jzUI/Q59viwWhMPgJHyvKLwUDL8SRUU9iI5bpn7O/gBjvpx8YfL3eUkoASBW9d
	 XMJ4ecQPjgUeehM9Kkl+qZKSj5OmEO/zA0Og+ZDAY59GROgg07MY37SquRK6XWvFO0
	 EDAdgIsCbFnKKqgWngWXnTyvNMBBlDGED/SSWn4HtB35aL8OBBAY0mSRZiIROQTOfw
	 Mn+bOVnI9663JoqFC7/rZppKlIWw9gYPZ/U7FYxulcbMpmRqUA1uxBVvwm6MNacdFt
	 t4mKus2IF9IEUT5aK8VQZK9zhM49cqnaV/DMxxtHGdyELshTGn3X63isSoGj4SztDH
	 uQ1RprzaljnHA==
From: William Breathitt Gray <wbg@kernel.org>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Raymond Tan <raymond.tan@intel.com>,
	"Felipe Balbi (Intel)" <balbi@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	stable@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH 1/1] counter: intel-qep: Use devm_mutex_init()
Date: Fri, 29 May 2026 11:34:23 +0900
Message-ID: <20260529023428.615928-1-wbg@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <177941369796.201156.12547650998958016276.b4-ty@kernel.org>
References: <177941369796.201156.12547650998958016276.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1220; i=wbg@kernel.org; h=from:subject; bh=W/6fTn2fiWbzOsj1NzyPspeYDJWY0xVzhnjsb7JjLvQ=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFkSv+VzTPhu3ZshvaD9hK79j5/dbIx7XfXbDcQfXPjKf HBVb8/ljlIWBjEuBlkxRZZe87N3H1xS1fjxYv42mDmsTCBDGLg4BWAikdEMv1mvJL34ajR7xuKl p32s7lz82Kx3P6L21oR33jxfI/kqfhUzMqzYNyOwlf9OxOTvifP7tXapRvYcESrMq93c8evl8lQ tS04A
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256461-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wbg@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 898415FC6A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 10:36:15AM +0900, William Breathitt Gray wrote:
> 
> On Wed, 20 May 2026 14:18:12 +0300, Ilpo Järvinen wrote:
> > intel_qep_probe() calls mutex_init() but lacks the pairing
> > mutex_destroy() calls. Convert to devm_mutex_init() which handles
> > cleanup automatically.
> >
> >
> 
> Applied, thanks!
> 
> [1/1] counter: intel-qep: Use devm_mutex_init()
>       commit: ff35c72101d1dc6793496ade9c1bc3d70dd27bdd
> 
> Best regards,
> --
> William Breathitt Gray <wbg@kernel.org>

Hello Ilpo,

In a similar patch[^1], Jonathan made a good point that a Fixes tag may
not be appropriate for this patch when it only affects debug information
as Joshua pointed out[^2].

So I am going to treat this as an update patch to intel-qep rather than
a bug fix and remove the Fixes tag and stable@vger.kernel.org CC line
from the description. If you feel that this patch really should be
picked up by the stable trees, please let us know and we can discuss
further.

Thank you,

William Breathitt Gray

[^1] https://lore.kernel.org/all/20260527175513.0df47897@jic23-huawei/
[^2] https://lore.kernel.org/all/CALoEA-wrYjbkhM7EiS+f-JjXShpRJw+gqy2zzymq9Ue5t-XN5A@mail.gmail.com/

