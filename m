Return-Path: <stable+bounces-204530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E58E9CEFC98
	for <lists+stable@lfdr.de>; Sat, 03 Jan 2026 09:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 898AB301226D
	for <lists+stable@lfdr.de>; Sat,  3 Jan 2026 08:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34232F361F;
	Sat,  3 Jan 2026 08:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=m3y3r.de header.i=@m3y3r.de header.b="uAzIEIBm"
X-Original-To: stable@vger.kernel.org
Received: from www17.your-server.de (www17.your-server.de [213.133.104.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795E32F28FC
	for <stable@vger.kernel.org>; Sat,  3 Jan 2026 08:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767427337; cv=none; b=d3X/aYJgiXLU2sLD6nSGJKWt05SwJv+zT74WEby2U2I94EKeeMw1FdAmAMGDUOZX0GxuT9S0sls8t+4KKxwhaZbSYVSvmCUWWR8t/8r6RwxR4bq2LKYUmekqteVwxQMFcJiL6vFyDGJHPmkH/c8dUnc+9EGBx83l90WPfcGeaB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767427337; c=relaxed/simple;
	bh=tiu8jFw2u7XpQk80KCe9pVqkkvn1SwQUPbqNCk5N7Gw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=AgVAWjstriTpKB24lTCnGWU1LPPoeovylo8T4VPT2CkFP4uUMAYvSubHbW0HCAELZP+UvhdFk0jL2db11qgsEcc9MM8rIn8MKdUjWF3VtD36NpdUuXvW5KqJkAWwwpRVGHz2sVIMAXZb5sozeGmCk25gTYkSoFP8ccT0a7daA2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m3y3r.de; spf=pass smtp.mailfrom=m3y3r.de; dkim=pass (2048-bit key) header.d=m3y3r.de header.i=@m3y3r.de header.b=uAzIEIBm; arc=none smtp.client-ip=213.133.104.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m3y3r.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m3y3r.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=m3y3r.de;
	s=default2402; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=tiu8jFw2u7XpQk80KCe9pVqkkvn1SwQUPbqNCk5N7Gw=; b=uAzIEIBmbNHnJVzRqguT6+ZVfm
	pemZ1kHTfMQ0f0v0rG/C+KUP3ef+w89eARPh2F/Q0F1n0BfK2KjAI8ouG/qi4jMl0Z8eQHj+ZyuSh
	s2zOw+FVwhyvy4+3IsgQEUpIHbrs/9gDiJg6+/5jKeO71YdDCGJh9aD4M1gG3/0DcZBKZSIMKiD0F
	DLMw4QMwtmM9eI3e/Bd2OpF6b6oHXeE+OMDIZ1OEkY/kdjmaHH+CGu1TPKy1toRVRulDJNFp3NwZG
	wDiOe8/s0P/ynFGxTPKnRvg19ITXPw1AMvM74KQ+CEjBJLGVODl+zgzEMEPfqMMHrBvkLV1p0MtSi
	SZY9Tkrg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www17.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <thomas@m3y3r.de>)
	id 1vbwaK-000K3O-25;
	Sat, 03 Jan 2026 09:02:05 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <thomas@m3y3r.de>)
	id 1vbwaK-000LHH-12;
	Sat, 03 Jan 2026 09:02:04 +0100
Date: Sat, 03 Jan 2026 09:02:02 +0100
From: Thomas Meyer <thomas@m3y3r.de>
To: stable@vger.kernel.org
CC: johannes@sipsolutions.net
Subject: Re: 6.18.2 iwlwifi broken, API version 4294967294
User-Agent: K-9 Mail for Android
In-Reply-To: <0b3219c015de2623ebd5e18d927a995e97095bfa.camel@sipsolutions.net>
References: <72464EF2-D744-4151-AB30-96C1EA41B482@m3y3r.de> (sfid-20251230_233158_225745_362CA8B5) <0b3219c015de2623ebd5e18d927a995e97095bfa.camel@sipsolutions.net>
Message-ID: <582EA36B-91F1-4A36-B524-5F4F26208F21@m3y3r.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: Clear (ClamAV 1.0.9/27869/Sat Jan  3 08:25:47 2026)

Hi,

Can this fix please go into 6=2E18 stable tree?

https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2Egit/c=
ommit/?id=3Dca5898222914f399797cea1aeb0ce77109ca2e62

Mfg
Thomas


Am 31=2E Dezember 2025 09:15:08 MEZ schrieb Johannes Berg <johannes@sipsol=
utions=2Enet>:
>On Tue, 2025-12-30 at 23:31 +0100, Thomas Meyer wrote:
>> Hi,
>>=20
>> This patch broke my laptop's wifi:
>>=20
>> https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2Egi=
t/commit/drivers/net/wireless/intel/iwlwifi/iwl-drv=2Ec?h=3Dv6=2E18&id=3D5f=
708cccde9d1ea61bb50574d361d1c80fc1a248
>>=20
>> The API min Version is shown as:
>> Driver supports FW core 4294967294=2E=2E2, firmware is 2=2E
>>=20
>> Looks like some integer overflow for my old hardware=2E
>>=20
>> Reverting the patch makes the driver work again=2E
>
>There should be fix on the way:
>
>https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2Egit/=
commit/?id=3Dca5898222914f399797cea1aeb0ce77109ca2e62
>
>johannes

