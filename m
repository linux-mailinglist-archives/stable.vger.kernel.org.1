Return-Path: <stable+bounces-247317-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEPgLUyIBmr0kQIAu9opvQ
	(envelope-from <stable+bounces-247317-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 04:43:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D810548D00
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 04:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC93130480D1
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 02:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177913C276F;
	Fri, 15 May 2026 02:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=augustwikerfors.se header.i=@augustwikerfors.se header.b="gUq4ajLg"
X-Original-To: stable@vger.kernel.org
Received: from retry-chloe4.scw-tem.cloud (retry-chloe4.scw-tem.cloud [51.159.124.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236643C0604
	for <stable@vger.kernel.org>; Fri, 15 May 2026 02:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.124.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778812924; cv=none; b=npLfHQ0x7Yn/KGTkD47rIpPb8AKLFnfbfaQFxjX7JZBYKMdFr74ColNqj1d5avn52xm7bKagh432j6jxs386RE92aQ9ZB676eU6Q6dn+0ywg9mz7u9FWwoseTLO+N5l/0aY70O2lUjHXCL6lJs/zIb3e6Vd7xK8N6nWFOmCFauc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778812924; c=relaxed/simple;
	bh=ew7VQjXWjgeV6HZGAKFsqPlJHT91mWIVTWDUpOChy+U=;
	h=Message-ID:Date:Mime-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rgq9hghn2VzF1tifUGMD1Dc4u6xhBsXjX6/r8N/Ynyl1BLZekgjmxzPof/tqepQUkei3b5QJEU39MzYWyNy2+keY9rPca94NwILw9iFFdSDhJMb5jof9NeFGUBs4gCjky3e1NYGbbKGCphFs/YapVcbUfH4UTjQE6l+NEgTF8m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=augustwikerfors.se; spf=pass smtp.mailfrom=augustwikerfors.se; dkim=pass (2048-bit key) header.d=augustwikerfors.se header.i=@augustwikerfors.se header.b=gUq4ajLg; arc=none smtp.client-ip=51.159.124.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=augustwikerfors.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=augustwikerfors.se
Message-ID: <51b55b97-615b-4f5e-b454-df646f4058b7@augustwikerfors.se>
Date: Fri, 15 May 2026 04:26:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: August Wikerfors <git@augustwikerfors.se>
Subject: Re: Linux 7.1-rc3 regression (Bluetooth)
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 stable@vger.kernel.org, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Pauli Virtanen <pav@iki.fi>, Mikhail Gavrilov
 <mikhail.v.gavrilov@gmail.com>, markus.suvanto@gmail.com
References: <f652d5d9841a9b7c100dd19ee97c86099f580724.camel@gmail.com>
 <01ffb0cc-dcf6-4e60-adf3-fbb96e0666d0@leemhuis.info>
Content-Language: en-US
In-Reply-To: <01ffb0cc-dcf6-4e60-adf3-fbb96e0666d0@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scw-Domain: augustwikerfors.se
X-Scw-Tem-Message-Id: 2f57aab1-d47f-4a11-80b0-5725a4ba193c
DKIM-Signature: a=rsa-sha256; bh=yReQT2nv0QzV9P4GZJON/h4X3M8148FFEXXI8CspZ9c=;
 c=relaxed/relaxed; d=augustwikerfors.se;
 h=message-id:date:from:subject:to:cc;
 s=812a4465-b64d-440c-bdd2-3148e8f56cf0; t=1778812001; v=1;
 b=gUq4ajLg0IGQX6w/Q/6GA4HPgbadfB2cXrr1u+5GSymnARud3dDM3Ii1t+SCvYHeon+xmvHp
 YTNQdNUWi3+fjGkZ/JXAUFUREBYctHkhwJ5kcyR5qFVi0PXObb+8YtL5Whc9NJaCLUKZfb3ghW7
 EVzOSlsEYFyNOzQIcC1v6TGF7NbRhJpFEpDH0WOGELLGjNe+HmJ0zIpK2Vgo2OqW6GyGOpfYkAe
 khfvrK5wqLVzK8FfP6GptUhzyxuIEwRRvNTCSe9Nw1dsjont8EUP9joeuQnkylG8JVPs49G7HHN
 TSvR7MzmHw4x4ffXixsQIuX80haKzljGSKAPtYEYTWnYQ==
X-Rspamd-Queue-Id: 9D810548D00
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[augustwikerfors.se,quarantine];
	R_DKIM_ALLOW(-0.20)[augustwikerfors.se:s=812a4465-b64d-440c-bdd2-3148e8f56cf0];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247317-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com,iki.fi];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[augustwikerfors.se:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[git@augustwikerfors.se,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,augustwikerfors.se:mid,augustwikerfors.se:dkim]
X-Rspamd-Action: no action

On 2026-05-11 08:30, Thorsten Leemhuis wrote:
> On 5/11/26 07:17, markus.suvanto@gmail.com wrote:
>> Hello
>>
>> I upgrade 7.1-rc2 to 7.1-rc3. After that bluetooth  didn't start
>> hci0: Failed to send wmt func ctrl (-22)
>> My fix was to revert commit 634a4408c0615c523cf7531790f4f14a422b9206
> 
> Thx for your report. FWIW, there are two proposed fixed for this change
> floating around:
> 
> https://lore.kernel.org/all/20260508173121.27526-1-mikhail.v.gavrilov@gmail.com/
> https://lore.kernel.org/all/770d36b07311bf88210c187923f243fb9f126f04.1777058551.git.pav@iki.fi/
> 
> Given that this is the third revert within a short time-frame I wonder
> if we should fast-track a fix (once ready) to spare more users the pain
> of bisecting & reporting.

FYI the commit that caused this regression was backported to the latest
stable releases (6.12.88, 6.18.30 and 7.0.7). I encountered it after
updating to 7.0.7 and can confirm that the patch from the second link
fixes it. That patch is now in the bluetooth tree as e3ac0d9f1a20
("Bluetooth: btmtk: accept too short WMT FUNC_CTRL events") and a pull
request [1] has been made to the net tree. Unfortunately this seems to
have been a few hours too late to make it into the net pull request for
7.1-rc4 [2], so the fix might not get into mainline until next week.

As a side note, it is unfortunate that there does not seem to be a
process to prevent patches that are known to cause regressions from
being backported to stable releases. As far as I can tell, this was
added to regzbot tracking [3] a day before the culprit was queued for
stable [4], so such a process could have prevented this regression in
stable releases.

[1] https://lore.kernel.org/all/20260514172340.1515042-1-luiz.dentz@gmail.com/
[2] https://lore.kernel.org/all/20260514142703.267609-1-pabeni@redhat.com/
[3] https://lore.kernel.org/all/8a17737e-ba9b-4842-a429-c4eab3abcdec@leemhuis.info/
[4] https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=7780f283d14c8c6bf40fe9262219ad821a5dae80

Regards,
August Wikerfors

