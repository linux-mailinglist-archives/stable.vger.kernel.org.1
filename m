Return-Path: <stable+bounces-235771-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEx6BfS82mm15wgAu9opvQ
	(envelope-from <stable+bounces-235771-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 23:28:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2403E1BD4
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 23:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F5A2301DCDA
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 21:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52092FE56E;
	Sat, 11 Apr 2026 21:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chHtJNjD"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F59C347C6
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 21:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775942894; cv=pass; b=SdvltYrSM2LKp5kwhlWVgd2gnfxt6676OdldYmUyheAEmYyIy+2sQMS9B4+qNiGdrb4m12RBEE6XcaFnwH+c2xWyNOZsw3WpXAgOLF2f7631bR93rdmnaoqWU/M0hwPE6yMUp6F+p2k+VNyA9lN2eLufbo3h//peKTpldNmrolY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775942894; c=relaxed/simple;
	bh=QRCrK53l8UwEWSyLWN/n8ALSgs4igj/WkQCyjF/qrKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJOjKT3b5R3YX5Lz5klS2C4znsHQMzDqyI3ZSsOJc8f3rL06GnPSLsB06jEXLW/llhnJU+Ugao5pDb3SRgAbUrhM3DOtrdeUiyYRsEwUK/s8sGXl08kUIT16agcyPDCDRbMjLnO0zCIp+MHZ1G9P3oy47MzCdkMrmuYr0G5Qpk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chHtJNjD; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b6b0500e06so5586959eec.1
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 14:28:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775942892; cv=none;
        d=google.com; s=arc-20240605;
        b=CE4B88+hrGIlWBkruFUN6hpoy6e/QCLuVf9OXQEhhWXZWmH1VuyyKsHmoPk5VhOm/j
         GGT9AyBKANHPWyduQB8tWqsmioYeRwBqqXiNAetMLreawQ+1n2j71kGmFqvSBXVM5JiL
         +58DQxDPl/tLqkJ/CrABV0zoGrLLMk5vW9IxCKoDrxMwBwZqh8ovgYeuzime7O7crHZS
         Fvqncg90z+qt/KEg4HZ+EyK/Hyk9pog01V9nCg5rcCJAgTlEooBa5d6gpnv+MH//lSvJ
         Cn/FYX4voLIfeDvqu0VCEINMwYaxQNVZq56DBRAtAVosd6loOeEK4oiYKc+vwc6El0lL
         VPZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QRCrK53l8UwEWSyLWN/n8ALSgs4igj/WkQCyjF/qrKg=;
        fh=5h7Rhroz9vcFbbePAK/iKZyq1emYr+C8I5CdOXOQ0DA=;
        b=YazFmrEL17ltmshHz2UjBtT2VPHqqoJ5de3O8T1d6p/D3TyvIf1J6F2dR8hWGp8I42
         16lRHAQDWMw0GOVcw1obIHeYJkZZuDKaVKJObsvwaXzlxaCSILWw8yFFwRnnOlg7rZJ3
         Fyznvm+yVxg1eTVbB12Eqt5w+VGylcIKDV8POOi0TLru0HwG5J9JHzBdzt2M9kx7gS1j
         s/XpRY+CjgIWBD58KR/V7a2O+Rd64DxXVI+RwsevTBfXUOSXTWCI7rFLZ4+B8PEgkMAj
         GtnNmmkaqty7aYrtG0HfGmnjc+YvW+FlY8OPKm4tGn3Kihzj6xy/aNJikT40Aerohs1l
         zCTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775942892; x=1776547692; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QRCrK53l8UwEWSyLWN/n8ALSgs4igj/WkQCyjF/qrKg=;
        b=chHtJNjDyvsEEZhg/7flJBCIX8EIYANNhryB+H2cLPuTbiwMpTwRescLLMp8GNSHNg
         mtGxFpB1speFHT2Ti+dZ1Hnt5zoDkh3mRvuhWi6atywpjJBwi+3v4drmdeL5yIZByhnX
         EcSweFrFgBtT1nFuxrdNPJStTMLgNiWyNZFgq3S/B6CrfNAm96B1N2iqjfj9SepfAozh
         FB4zMmNn7SMvhuCbXkCtThi0EzzvIL1xt3Nc5peSQBLeYfhIcDr/UGj/JRkrZHx2THXo
         jz7zXfL56wL++0MP2fWnPlL4r1E44/iU4lALy3N2xFBKEZY6cluUN7FvLkn999A9lQt9
         WXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775942892; x=1776547692;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRCrK53l8UwEWSyLWN/n8ALSgs4igj/WkQCyjF/qrKg=;
        b=gZjnqUNnYVPvMbTXSzVXFZIuQeCkedO0MTRMW1XkfmCgsAACXkJi0KoNNrOifABU75
         UYILQThKDS3CTXR1VsR4NcYt8hrDu0gVNMtHL3AGk1NTWjftUNlrdk9hQRYoHvmyU2sU
         c2dFS/ZPzIKM1R+9hJbyg73Cr2s15grCEFDc5oC+sE97dANZ7sXqLSLT6uMfWnY0wk/R
         PXQzvv1WkY4ZBoJBCQkpLcOdKr67v1nn6ftU7T49+KayihxZTffmMYDgswNbhtkiQZr3
         nlv9PKHIUYL14ns1JALw20r5wVvqAQ8M6IFz1/3pG2CX/tWChn0tSYeCiwu9NhimTlYS
         77gg==
X-Forwarded-Encrypted: i=1; AFNElJ8p3SlAD7RudswV8HIOqHEhyCn5QdTfvokoiM7HnDzwK+tvgvtn12TekcbfvfVkYORnASLIgv0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2RkBho8EJ41/XW1ehHCYSFkgFO2qWkBtv05OzOELRCVV4fb74
	aj3cNbbc8vAHbq0tAFVM9tfiIx8zaqONoVxhxW5wNGysp5+ba2MdqIf8idDEw8mdpvYsG0Qoslt
	pZOhvbqpmsBN3AxOwaDv4NBVhc3buJNM=
X-Gm-Gg: AeBDieuWgd3DM0rh4JrmvQ4ERSVJDPs7v17+HOZ8jDfd8Eb/i+Yc+ia3izeeFc4CQop
	X+sUsy3UuqVFLAJaUK30LG0f9ws4xGeHbwYskl0PZozc27rktO3iANY1RjMGc3suDb6LWFbyPhM
	ngNXW4E80CcMVSqXYnZa0QIHzXORhjUQWoFjP4bZostYEJ4OkEDWINMVne7iLXP4iZ9yA/9UnqQ
	sCPAkYkCR/EHPNL53QltbvfBOTgqDfKsd3otS00JN1BUfHSWc8Xvhf6nr3+4sz2McA3kW6PZdwc
	VY21F1JT
X-Received: by 2002:a05:7300:e207:b0:2d4:afb3:7af4 with SMTP id
 5a478bee46e88-2d587990c51mr4531084eec.10.1775942892437; Sat, 11 Apr 2026
 14:28:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303104217.180715-1-goodmartiandev@gmail.com> <20260315081221.2678478-1-goodmartiandev@gmail.com>
In-Reply-To: <20260315081221.2678478-1-goodmartiandev@gmail.com>
From: Sheroz Juraev <goodmartiandev@gmail.com>
Date: Sun, 12 Apr 2026 02:27:59 +0500
X-Gm-Features: AQROBzA8jYuUrNGsRBpoQAuIwELHw6dxtkiMbmYTNVFngUW0SiZDuEnRMISRBGY
Message-ID: <CADPJysxbXtB_nPpMt5_FZaqsEWP_e=3QjKk+j8R9NuTfJFvU2Q@mail.gmail.com>
Subject: Re: [PATCH wireless v2] wifi: iwlwifi: mld: stop TX during firmware restart
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235771-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goodmartiandev@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF2403E1BD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Gentle ping.

This v2 was posted on 2026-03-15 and hasn't received any review
feedback yet. I realized after sending that I dropped you from the
direct To: line in v2 (it only went to the list), so this ping is
mostly to make sure it didn't slip through the cracks.

Since we're currently in the 7.0-rc stabilization window, I wanted to
check whether this small bugfix could still be picked up for the
wireless tree, or if there's anything you'd like me to change.

Patchwork:
https://patchwork.kernel.org/project/linux-wireless/patch/20260315081221.2678478-1-goodmartiandev@gmail.com/

Thanks,
Sheroz

