Return-Path: <stable+bounces-230346-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOqLNd7nw2lvugQAu9opvQ
	(envelope-from <stable+bounces-230346-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 14:49:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B3E3261C6
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 14:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B5AA301649F
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 13:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C78D35E956;
	Wed, 25 Mar 2026 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="YGfGRCy3"
X-Original-To: stable@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A7A26CE32
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774445903; cv=none; b=Pc3krJ/QDwm0nZ6AKBCGJAm/wWgVTgikFSIftOFZBpRhamO2lj6I9GvvH631cTz3+7/+XS4ZTiwRvQz/qY+3Tp++LqshwOscNHhyrJbw7zGiEyrg7FPYd0clM/EuJv5m+mg1N74PesPA3QNRrybBAICqKe8lirLarGDUERKDN7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774445903; c=relaxed/simple;
	bh=KYgT70MUsHwQlM/4cfi+uo2BeRI5d1V+MMketwI+s3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOuzwT30K4XPtZQLQZ3wBFjQydect2BxUj+bF+5MaOX/flyQju9Sc/EdrPy8T7p/gbBR6KOZRLOyaseQex2QXW53ST6CYFsEC9irceQZQWEJV0+LslpOwJjN8e6C1RK6UX7stS3cgsBJ4MXQ3tvyPRhUTNOCQX+Z7/38reXSfLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=YGfGRCy3; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (172-245-102-52-host.colocrossing.com [172.245.102.52] (may be forged))
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 62PDYu0X006721
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 09:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1774445705; bh=VYpbkawdJVNuKw367M8SoRscvuu7Nv1RyWd0oyP5C9M=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=YGfGRCy34QJLRAAs9K2a7CKYcOz08lIuU5fO+xU5yJauWEfiVzL8J7BAQJBBnX6xH
	 fQ+06/jhI/HUcbmTmmW3Sea1N9HVyBo0/3MzT8lmbWapPMcgG1MU8oFFeGu6xkxqH1
	 6mhag6C29mQJ4O/Wdxls0tgB2tDI996Y20E4MF5IHNMVCGsQLKihtb2l0J4tGqUGLH
	 duA0Yhc/NbSAd9PzfZ0jtY6+ZQ+oYDhtJPMg6cKYcqGsI3dVt2AlP3IHlHzEyXpeST
	 ebUJJIEHbxEttM8XMzZI8SIHANCIdA5qDEcvxbbfbkxGyURshmPjeYzfOE+pcz/tz2
	 9JZ+Q9yD7j0oA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 6217F5F3E9DC; Wed, 25 Mar 2026 08:34:56 -0500 (CDT)
Date: Wed, 25 Mar 2026 08:34:56 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Sun Yongjian <sunyongjian1@huawei.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com,
        jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com,
        broonie@kernel.org, achill@achill.org, sr@sladewatkins.com,
        Jan Kara <jack@suse.cz>, Brian Foster <bfoster@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Gou Hao <gouhao@uniontech.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>, Zhang Yi <yi.zhang@huawei.com>
Subject: Re: [PATCH 6.1 000/481] 6.1.167-rc1 review
Message-ID: <20260325133456.GD2107@macsyma.local>
References: <20260323134525.256603107@linuxfoundation.org>
 <20260324073447.GA5062@francesco-nb>
 <d22ffe9f-8cd5-41ee-9da1-d0d2800a5f16@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d22ffe9f-8cd5-41ee-9da1-d0d2800a5f16@huawei.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230346-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[dolcini.it,linuxfoundation.org,vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,suse.cz,redhat.com,infradead.org,uniontech.com,huaweicloud.com,huawei.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[mit.edu:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,macsyma.local:mid]
X-Rspamd-Queue-Id: 72B3E3261C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 05:03:37PM +0800, Sun Yongjian wrote:
> Actually, this concurrency issue stems from mainline patch 060913999d7a
> (part of tags/v6.11-rc1), which reordered the migrate mapping and folio copy
> operations. Since 6.1 lacks this patch, the race window doesn't exist there.
> My apologies for the missing Fixes tag.

I'm confused.  That commit 060913999d7a should be backported to
6.1.yy?  Since 6.1 lacks this patch, I dont understand your statement
"the race condition doesn't exist there".  Or were you trying to say
that the _fix_ for race condition is missing in 6.1?

Or is there some other commit which fixes 060913999d7a that needs to
be backported to 6.1?

Thanks,

     	       	   		     	     - Ted
					     

