Return-Path: <stable+bounces-240119-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGbuHY9M52lW6QEAu9opvQ
	(envelope-from <stable+bounces-240119-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 12:08:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9AF439554
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 12:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7BDAA3017A21
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 10:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CD0386450;
	Tue, 21 Apr 2026 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMmw0WBL"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0F83B4E99
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765944; cv=pass; b=kGGmTEVo1Nj3nQYOPMJJE59xZcLBwNdnTKM0mAgepGiS7lvaykU/wTUQ+rnBSZ8dXHX7iUXtzxb8PN/JuMZfq/LbA9dx15ayBqlGTI/3/+lOv8wlW8TlkGSLcMbAb0YKi/5EE/lv8eQzIoOJjS6xkEVeRd/vzkuU279mC4i2680=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765944; c=relaxed/simple;
	bh=YyerS+ssSLZLHal/c0zlG9T7hN10Qn3AYCrzmaiROnE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=papfXAnBYZNNxXh2HPf/T9EJJqcuF4S2i5SOnegu5bfex4g+Q5sCVYeGKC6x+XKICDdMYqejEmUCHTZ4wiZHDiYIHRKM/hfuOEI+8YGMPe2mRcGFpin1VhjDn/keeyao6/9MENWB48F33qqchDJ1hYPrQw4inTQIl5ztWHrXiFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMmw0WBL; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2e92c54bab4so231502eec.0
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 03:05:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776765943; cv=none;
        d=google.com; s=arc-20240605;
        b=Mm7CkXq8+FG63OBHDEjkQGLGSmrGWSmyGzNJFIba5CNHSwSQ4Mz0o6qJPvIYXcc2D8
         7V7Hq7TX4xRyxc853COD/qDLTNlHXNW7nz5n4YcyLSbH+eCQqN221aoahoY32/kUGMsE
         i+s7+2eTsVqjvOV2gA6aty7ZhnDR4R4n33RZh6CE2d4/3wLqMYypib2NhHMkt6FNGf+w
         uhICcS4k/GXgEDxz/uPIysDo0k0VVGuuW9w4UQ2DUsbKC5/+KqgajP4hoOWrA9GY1mPQ
         TKfT0qVF1oNpG/pmQxCV2T5ymnTnOO5wGtmoJO57z23SNoFOc3vBSGbURflYS5xUSzAz
         5e2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=1dZ/Fp8cG6i9MYpHL3TtWcrwUGEg5Pe/LLPLGrUqrCU=;
        fh=te9kzfqRZmLccFvs9XJQ44BhiIvLUs56S9THMXx8AyU=;
        b=GX379QnKmM3imM1/Uz9fnNFMMdbFJ04A+l083enEIwSEPvDDKlfHFdLnUbP3Mu55z4
         fcx6gmNx50Lzx5R0JboVazMotd7cRvVVG+a2wty/w3KLXrFujjEpLSkW4Kku5ZYbyf9i
         djeWKSVPFltKgDu9cydSDCO6750ppBknKXQm8K+DgJK5PiUg+kQVZfhWDkv42iNNPE4/
         OkJQZpmc8XOyjvehYglgl1ANFpwKpHpVT4XGky5Rx0BV3e3snMr0RHImkf9C2Cr3/0kr
         WQKZ3mKvO+vWXDtvr0l149d4xV+Qk91PPXqfe+HzUB2LuxKHt+Kj0ZQCk6wi2Yd6JrGx
         r0Bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776765943; x=1777370743; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1dZ/Fp8cG6i9MYpHL3TtWcrwUGEg5Pe/LLPLGrUqrCU=;
        b=cMmw0WBLo0uIFQwJpetLfxzltor1uknW7tLQZrOIxDJBTxShktFaU54u/Iam959uVI
         qKSZsuZWDkXdmEHsfujRGD/DZ4ai2/ViddhcG24BS6T6splbkxZHWjX4UxTGV3f0q5Xv
         XoLGfvpeXAw0dT9QiL4ZdgHeLczrRjdWxsIIKJ6I5b34kSTxEN7bGjxn6nlH62/UWJw9
         3rCO8iVz6Q8I1SdGKMiJbvgi0C43lXLyinEnsHxydTRCmRmwL+lvACLdCtNuNkdUJ7qS
         JyNYwGL92z/xudkcWWEbkQYAkrx9+izfDhBfVusJwULYDLzFaNKPl42tCUMa4ky27IqD
         yQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776765943; x=1777370743;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1dZ/Fp8cG6i9MYpHL3TtWcrwUGEg5Pe/LLPLGrUqrCU=;
        b=Mm0D+C9vQ46vyDiBEhHqGCYLO00xjcOU2sRtXvQWNPsaI00AGTkFZJ0bLnMFtR5Zip
         ikc+WDtm49lxIPCGi+XdYv605OoIykhA/xgelu3USf63xohY69iZZAoL7YizsIOPva3Q
         1IZkCErZN3vXdM1DJYVnNJdk2Viy+hEWQuDa/4kEES7nWafKABjIecg98bo1KKzxhZOz
         BWgzsX+751d817YIqjTV6JK6FL1tYUM/UoShOFESe7QHHu4Fs04LGjzo+7t17aQ2/8iK
         Cs9gwk7UPaO4Ri9RDw8wiKoMYOYRyK7FN+5LSpJftXa/9JlNry31szLciOQgtJNyUi1G
         n/UQ==
X-Gm-Message-State: AOJu0YzAqYkzmCkX0UiS3D3UJBccHVGiRT4YKai+LUk/qKno6Ui9qQR+
	38tTcEuhzrQtMzJFUuylVToWsJl/pbX5nBQJK8B5fBaMNS+3B4CWbPmT9p2lu0QW/+PbF1MNM1r
	ubAclipfuxYg+f/nyfFvUuV9lasQE0fM=
X-Gm-Gg: AeBDiev9WItXml23VRVQZtA1vdK99vuErlL36r0att+5LuxtYs1pmcXAE1JtpoI26O1
	SpX8YipoQK50HFxahZr7H1mN/eP2eMoRMivpOqQTIqsTXKinnxxTYJyGLkE8thGdm69GUKKwJUX
	hNhrLSBzrhn1uhOYQcN8KuXe+AaMo/GA9bERABron30wxfftGbHNIUIKiJpSYxT1yAFwk1AJWke
	Isg5nnreEfXyUvaa1rFRjFu15PCpn0zGQqMYZwrtIY8srsDeX8JpvFpyNTWzRLsb4JqM8OW5fh2
	4P8oWgYnDC1eqEx7iaH5dXJHjW8EdRzRvPs7gdzsZvU4N1FhOPWknCh4oK6S565m/kin8WTczvg
	R+DHvHH7T0B8BtzzmSKNcpl9f8BlUi5FTf1ZTpugZmveg
X-Received: by 2002:a05:7301:1984:b0:2d9:94b4:a1bc with SMTP id
 5a478bee46e88-2e479517ab5mr3706270eec.8.1776765942884; Tue, 21 Apr 2026
 03:05:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 21 Apr 2026 12:05:29 +0200
X-Gm-Features: AQROBzBHndCdnCZ9AkZQJc_y_l5t9egxWJ2AbAQmbhMA8aKX5dBFyeoPiO7wZgs
Message-ID: <CANiq72m7E3E86XwYT5c_3osYHiS9bp6pu7LQBjPFY+d8=8XsoQ@mail.gmail.com>
Subject: Consider aa8f35172ab6 for 6.19.y and 7.0.y
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Michal Wilczynski <m.wilczynski@samsung.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240119-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MAILSPIKE_FAIL(0.00)[2600:3c15:e001:75::12fc:5321:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8A9AF439554
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg, Sasha,

Please consider backporting to 6.19.y and 7.0.y:

  aa8f35172ab6 ("pwm: th1520: fix `CLIPPY=1` warning")

It is straightforward, and perhaps you will automatically pick it up
after -rc1, but it doesn't have Cc: stable, so I am sending a message
before I forget.

(For 6.19.y, if you are dropping it soon anyway, please ignore it --
this is not an important backport of course)

Thanks!

Cheers,
Miguel

