Return-Path: <stable+bounces-242258-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MObuLBB59GliBgIAu9opvQ
	(envelope-from <stable+bounces-242258-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 11:57:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5764AB716
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 11:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E73B300CC02
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 09:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBEB382F36;
	Fri,  1 May 2026 09:57:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD5D383C78;
	Fri,  1 May 2026 09:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777629425; cv=none; b=CmL4RANldFyR5/4aFXgyd64QTIb+92g/tHUYzZqR1qOdLLZeM4nWrz75kHrbXSCu7RHNQzuo52ELKSQHmJM/36OXvXDNtVjqFmfYwgBt31wRmJESClADJoOLQpakhenh54nnEjytPnSv4NYeXxkDy5FjOX+I6U8KFkMj1LYzJnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777629425; c=relaxed/simple;
	bh=14f8v1j4Unq/XnB8Px+HMj0IobnopHjOjqUg3Llbtvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FSdZRN9R+mXnxgPiEJYor3WXc+5MjJc2MYtX0U7rsbDXt2tE352p+YqNTUx8t2DHMPkKDMW2b1S+czM8YUZLE/8+rQWrIx1ZhbaTM+H4/SRsA6RHTV4jZZEro7nHJJZ0rQDPNLh1D+4v7Xi+KWEyju2ZAHG4ug4w23twbPD48hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.229] (p57bd9b5a.dip0.t-ipconnect.de [87.189.155.90])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7FA1D4C1A2DF81;
	Fri, 01 May 2026 11:56:42 +0200 (CEST)
Message-ID: <07194e8a-c3b2-4cff-8690-8c0ac36a96e8@molgen.mpg.de>
Date: Fri, 1 May 2026 11:56:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: copy.fail and backport to LTS 6.12 and earlier (was: Linux 7.0.3)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Luna Jernberg <droidbittin@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 stable@vger.kernel.org, lwn@lwn.net, jslaby@suse.cz
References: <2026043052-coasting-tinwork-27b5@gregkh>
 <CADo9pHjPzxmHNd8MAeWH=CCuVazxpb3OxdasEcUxoarvLwKzZg@mail.gmail.com>
 <2026043052-deflector-dodgy-93a6@gregkh>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <2026043052-deflector-dodgy-93a6@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0F5764AB716
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,vger.kernel.org,lwn.net,suse.cz];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242258-lists,stable=lfdr.de];
	DMARC_NA(0.00)[mpg.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[copy.fail:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,molgen.mpg.de:mid]

Dear Greg,


Am 30.04.26 um 15:15 schrieb Greg Kroah-Hartman:
> On Thu, Apr 30, 2026 at 03:09:05PM +0200, Luna Jernberg wrote:

>> Works fine
>>
>> patching: https://copy.fail/ next ? ;)
> 
> That was fixed a while ago in older kernel releases that you should
> already be running :)

Thank you for maintaining the stable and LTS series. Release from 6.12.y 
and older do not seem to have had the fix included upon public disclosure.

Commit a664bf3d603d (crypto: algif_aead - Revert to operating 
out-of-place) [1] fixing Copy Fail [2] went into v7.0-rc7, released on 
Sunday, April 5th, and the backport appeared in 6.18.22 and 6.19.12, 
both tagged and released on April 11th. For some reason, for older 
series, the backport appeared in 6.12.85, 6.6.137, and 6.1.170 and 
5.15.204 yesterday on April 30th. Several Distributions like Debian 
stable did not have the fix included upon disclosure to my knowledge.

Do you know what happened? (Not that I have any demands or expectations, 
as most Linux kernel users use it for free and do not contribute to it 
financially or by active participation. Also, my institute 
infrastructure was also not affected, as we build Linux ourselves and do 
not have the module enabled.)


Kind regards,

Paul


[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a664bf3d603dc3bdcf9ae47cc21e0daec706d7a5
[2]: https://copy.fail/


$ git log --oneline --grep a664bf3d603dc3bdcf9ae47cc21e0daec706d7a5 
stable/linux-6.19.y
ce42ee423e58d crypto: algif_aead - Revert to operating out-of-place
$ git tag --contains ce42ee423e58d
v6.19.12
v6.19.13
v6.19.14

$ git log --oneline --grep a664bf3d603dc3bdcf9ae47cc21e0daec706d7a5 
stable/linux-6.18.y
fafe0fa2995a0 crypto: algif_aead - Revert to operating out-of-place
$ git tag --contains fafe0fa2995a0
v6.18.22
v6.18.23
v6.18.24
v6.18.25
v6.18.26

$ git log --oneline --grep a664bf3d603dc3bdcf9ae47cc21e0daec706d7a5 
stable/linux-6.12.y
8b88d99341f13 crypto: algif_aead - Revert to operating out-of-place
$ git tag --contains 8b88d99341f13
v6.12.85

$ git log --oneline --grep a664bf3d603dc3bdcf9ae47cc21e0daec706d7a5 
stable/linux-6.6.y
3115af9644c34 crypto: algif_aead - Revert to operating out-of-place
$ git tag --contains 3115af9644c34
v6.6.137

$ git log --oneline --grep a664bf3d603dc3bdcf9ae47cc21e0daec706d7a5 
stable/linux-6.1.y
961cfa271a918 crypto: algif_aead - Revert to operating out-of-place
$ git tag --contains 961cfa271a918
v6.1.170

$ git log --oneline --grep a664bf3d603dc3bdcf9ae47cc21e0daec706d7a5 
stable/linux-5.15.y
19d43105a97be crypto: algif_aead - Revert to operating out-of-place
$ git tag --contains 19d43105a97be
v5.15.204

