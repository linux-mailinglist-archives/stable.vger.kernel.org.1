Return-Path: <stable+bounces-80707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E690698FBC8
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 03:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752731F21B77
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 01:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84921862;
	Fri,  4 Oct 2024 01:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="UR42I2+N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NoJrE21Y"
X-Original-To: stable@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9BB1D5AB3
	for <stable@vger.kernel.org>; Fri,  4 Oct 2024 01:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728003644; cv=none; b=O0jgCAZrmPLdDzpj6NFAqNWahAkUZRRg2ZWAxvdjYZKwOp4vWCcxqfm2SWWfUMvqhbKatQzz6JzYDGjMBdl0/qlxSvGkbMorw7SaBJJolz3VFqM4m1fNmR2yi1pzdainV9iWUStFy4IQLYOCE1C46W0TfDf+7BqArPPJnZudde0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728003644; c=relaxed/simple;
	bh=6cGpN7wdn/WXu9F0BsWwDjMJOivcOFM+pb/2jNR+Crw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PU/navl1Tjw29xS0wfWWYRaqZD0gq4y7JSs6a90/4UQ7rQ3wM7X2aSnFATweBbml8eU/ZohJBqZOS4KbYHxgzgdQVzrnXkRoqcREffNblu/p6sMsUrZzP7TlxIvhGB1B8bO7N13Z2pPt/Yj9IyMh2kgpHGOKihA6hnYgQ3A55EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=UR42I2+N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NoJrE21Y; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 519BA1380244;
	Thu,  3 Oct 2024 21:00:38 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Thu, 03 Oct 2024 21:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1728003638;
	 x=1728090038; bh=ZagUyPZCf9yMxjzQJmJM3xInZuYnFoj1kKC6EypCLtw=; b=
	UR42I2+NrLi1hgd0M4Ccy2cyLicZVunV2E2pC7FYYS+NJNjomMHSbVNJHDANGi4Q
	mu/7IGB27k43lpuRJ9qwAVIkAsddcTRFKFZ+cCFrF96sXrJqdULc1vJiR8PahTr+
	/8KU9Fsog7BVsPg1eehUnRCJ5QFfqgCA91r/3OG2sMCaDDjkT0kNI0XnOVf+HEHH
	JTulDno7vlvvCtgSFxNksdKT+fC0ixVROIHgbsIlhheOrM/2UwPeQfVw2aX75Ywt
	O2oeAlDiS5R9+RzdXyF2oifgXfElgD3QtNu1I74yY/g4/FhWO+0K7Bs9f31geyK+
	w4RhLKjEeldq19NbkeoZhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728003638; x=
	1728090038; bh=ZagUyPZCf9yMxjzQJmJM3xInZuYnFoj1kKC6EypCLtw=; b=N
	oJrE21YGvGIzzzw3IoEAvqokkOz4HoyQt1Fgl5h9Q4Ev30k9Q8jmtak9i4081vuu
	CPPbc5Ec2UkSb5w/G2JZdImDPlH6E2739hjKZR8+nT/EzUh2X7MElGmYE9LU1Mjv
	70ktXA7xFUf5F9EWy2hMaeZXUsSZx+QYU/7wlgFtz/a89UifrkP6U9z0i89xf4jG
	JzPOM7rNmLnWrwltBrrXEX1lB0z6t6bnJy6VWV5uQ7M/Z26fOO2i89kyUI2EFN/7
	YkJMy4Hw0Zvo2ZUIvndQ82/u78EOWI5mYajeahwgYoh37gUGKa3L/9hcC9QsAK5M
	LslTP93dzeS8RdEUd2SbQ==
X-ME-Sender: <xms:NT7_Zk72l3Vo5-hkQierJOyQZ50mUdA-wKcGkjgQt4LgjDz6R9BRGw>
    <xme:NT7_Zl4P3JR0u6uN1PBZER043i3Z2FJEY6DOOYR3RkGB2yf4ukhuN7v_g9k92eWRt
    R4niYsISkfL8xFoohA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvvddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfofgrrhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnh
    hovhhosehsqhhuvggssgdrtggrqeenucggtffrrghtthgvrhhnpeegvdegueffhfdtleei
    gfejhffggfeivdejgeelueejuedtudetheejudehtdeitdenucffohhmrghinhepkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgdpnhgspghrtg
    hpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmnhhghigruggr
    mhesrghmrgiiohhnrdgtohhmpdhrtghpthhtohepmhhhvgihnhgvsegrmhgriihonhdrug
    gvpdhrtghpthhtoheprghjrgihrdhkrghhvghrsegsrhhorggutghomhdrtghomhdprhgt
    phhtthhopehkuhhnthgrlhdrnhgrhigrkhessghrohgruggtohhmrdgtohhmpdhrtghpth
    htohepshhhihhvrghnihdrrghgrghrfigrlhessghrohgruggtohhmrdgtohhmpdhrtghp
    thhtoheptggvnhhgihiirdgtrghnsegtrghnohhnihgtrghlrdgtohhmpdhrtghpthhtoh
    epiihsmhestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepphgrvhgvlhesuggvnhig
    rdguvgdprhgtphhtthhopegurghnrdgtrghrphgvnhhtvghrsehlihhnrghrohdrohhrgh
X-ME-Proxy: <xmx:NT7_ZjdXib2HewMrm3DSnkmGUiuhiE1fNx-zZ_nRusxZ6sNYC44jYg>
    <xmx:NT7_ZpL4bHWt1EJ-Jb_DPiradgwsYMXNauBDQiKbo_GHJ4El8B5P5Q>
    <xmx:NT7_ZoLGlOWeckbuYcPD2VMKF-byMZiF2k4pq8kUifTR7CHNN5FssA>
    <xmx:NT7_Zqztb6fE71zLb5_uhSj2i4iFkMpkyRU7GJjubn5j9E6TBRQlOA>
    <xmx:Nj7_ZqglteKj3-we89-l86EatbD9L5qFWaMZd4vle7jSf2VWKUkl36g3>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 79E083C0066; Thu,  3 Oct 2024 21:00:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 03 Oct 2024 21:00:17 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Vegard Nossum" <vegard.nossum@oracle.com>,
 "Greg KH" <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, pavel@denx.de, cengiz.can@canonical.com,
 mheyne@amazon.de, mngyadam@amazon.com, kuntal.nayak@broadcom.com,
 ajay.kaher@broadcom.com, zsm@chromium.org,
 "Dan Carpenter" <dan.carpenter@linaro.org>, shivani.agarwal@broadcom.com,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Hans de Goede" <hdegoede@redhat.com>,
 "Harshit Mogalapalli" <harshit.m.mogalapalli@oracle.com>
Message-Id: <744ace33-1a53-4563-8582-3b24986ccf32@app.fastmail.com>
In-Reply-To: <20241002151236.11787-2-vegard.nossum@oracle.com>
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
 <20241002151236.11787-1-vegard.nossum@oracle.com>
 <20241002151236.11787-2-vegard.nossum@oracle.com>
Subject: Re: [PATCH RFC 6.6.y 12/15] platform/x86: think-lmi: Fix password opcode
 ordering for workstations
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Vegard,

On Wed, Oct 2, 2024, at 11:12 AM, Vegard Nossum wrote:
> From: Mark Pearson <mpearson-lenovo@squebb.ca>
>
> [ Upstream commit 6f7d0f5fd8e440c3446560100ac4ff9a55eec340 ]
>
> The Lenovo workstations require the password opcode to be run before
> the attribute value is changed (if Admin password is enabled).
>
> Tested on some Thinkpads to confirm they are OK with this order too.
>
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Fixes: 640a5fa50a42 ("platform/x86: think-lmi: Opcode support")
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Link:=20
> https://lore.kernel.org/r/20240209152359.528919-1-mpearson-lenovo@sque=
bb.ca
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> (cherry picked from commit 6f7d0f5fd8e440c3446560100ac4ff9a55eec340)
> [Harshit: CVE-2024-26836; Resolve conflicts due to missing commit:
>  318d97849fc2 ("platform/x86: think-lmi: Add bulk save feature") which=20
> is
>  not in 6.6.y]
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  drivers/platform/x86/think-lmi.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/t=
hink-lmi.c
> index aee869769843f..2396decdb3cb3 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -1021,7 +1021,16 @@ static ssize_t current_value_store(struct kobje=
ct *kobj,
>  		 * Note - this sets the variable and then the password as separate
>  		 * WMI calls. Function tlmi_save_bios_settings will error if the
>  		 * password is incorrect.
> +		 * Workstation's require the opcode to be set before changing the
> +		 * attribute.
>  		 */
> +		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0])=
 {
> +			ret =3D tlmi_opcode_setting("WmiOpcodePasswordAdmin",
> +						  tlmi_priv.pwd_admin->password);
> +			if (ret)
> +				goto out;
> +		}
> +
>  		set_str =3D kasprintf(GFP_KERNEL, "%s,%s;", setting->display_name,
>  				    new_setting);
>  		if (!set_str) {
> @@ -1033,13 +1042,6 @@ static ssize_t current_value_store(struct kobje=
ct *kobj,
>  		if (ret)
>  			goto out;
>=20
> -		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0])=
 {
> -			ret =3D tlmi_opcode_setting("WmiOpcodePasswordAdmin",
> -						  tlmi_priv.pwd_admin->password);
> -			if (ret)
> -				goto out;
> -		}
> -
>  		ret =3D tlmi_save_bios_settings("");
>  	} else { /* old non-opcode based authentication method (deprecated) =
*/
>  		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0])=
 {
> --=20
> 2.34.1

Changes look good. Thank you.

However, not sure why this got caught up in a thread about CVE's? It's f=
ixing functionality that wasn't working on some Lenovo Thinkstation plat=
forms, but isn't a security issue in my opinion. Before the fix you just=
 couldn't use WMI to set BIOS attributes on a few platforms - updates wo=
uld be rejected.

I can see it might be nice to have in older kernels for some users thoug=
h. If you need anything else let me know.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark

