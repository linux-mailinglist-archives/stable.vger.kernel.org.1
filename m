Return-Path: <stable+bounces-215616-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DG2NjHmimndOgAAu9opvQ
	(envelope-from <stable+bounces-215616-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 09:02:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBE21181BD
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 09:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0978302D0BC
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 08:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978AE33BBBA;
	Tue, 10 Feb 2026 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cr27eOyX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4441917ED
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770710569; cv=none; b=CdzwDxkiuhXMF+RV4dCkhWZ69VxFE9aVzIf2XwAelGnwddI4PFdg5DAiCEWuC9f859X6To5A/+EJAm792RevYzUOEwJ2jhLA0QwgjCebI2YJw5jkuprAKU5K8oNAs8s999gnH6uePQTqkJBSsNx5T7yuczQwQzukGTxd7V0SJ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770710569; c=relaxed/simple;
	bh=bU4Wh1j1LBsmdEOgoQcTnPJXShDoevVY/x/m4yo+Zag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWoHPN/ArLAdrhu/aDDGtJAG0fWBkY/KhNsBYgkTQXy1EDKbnWSTozpxcGXjsq4qmU0xTmZ184fyhEvy9kwLsnHvXG0SXF0xFVhRsKSVMiee76QutqvoTpJ1yp1F0idc0j1DJJIuZIdbe0ikXGh5I9Oi0D1/5VpERjeCOu5awAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cr27eOyX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2aad1dc8856so16806225ad.1
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 00:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1770710567; x=1771315367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eRCOpIoQDRLHhIQp1Xgqd459kQKY7gr4fqWm7uq8GBQ=;
        b=cr27eOyXWY999+NLz8G2kE7QWLXYyKTugXeYi7xOmZqFUrTS0rR9PHuHTxIlmYswaI
         eUaSYry/58iVOXP3NR11V5WhB8AXanNI7FDnpmzv451RRQHyIWMIh9xSIEQrPB6XpDPi
         CLLZe0Pva9+y7KN5UjINrsF5YRY7pbtFDTA4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770710567; x=1771315367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRCOpIoQDRLHhIQp1Xgqd459kQKY7gr4fqWm7uq8GBQ=;
        b=dd1b8lYYGdXwa8wup6tHyv4Z2W6RiKo3RJHBFeEsVCnHBC/troQV6QcC1TcUoJEAtn
         e7YH8AB5XZvkvDU/6CrXxL4Ddlr5YycCk61PBqBLsf1LBdvC5A+5fc8TLuMjzYOvDWDT
         YpVktAhQcxJcLkbjG5+ofHOydEGt94YWbTSBFauG21fSfXj32uWgZg9uEn6P2KVvSfOa
         FLxCDLw7DxojjC7VWs8SmrG6U7taJctbi32pq4R/olFPCDAutEquLTiEnFYxSMMelnI1
         TelPUeqJwSSNfyPnQM6uTCBU8zcv+VYR0NZcHz2VrAqdsYm0F5Qhhx+IT6nQkxQX7dWS
         Rsyg==
X-Forwarded-Encrypted: i=1; AJvYcCVJMoPCisRfEwrXRHU4+922QuivLLT6Yda7tYqj68IcFfOYJrD87SQAa/Qfxe3fBQF4h1MKyYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrNdIrAeo7iw8OoWyqe3dB0aWbTvL2G/ttegFuk8u46lnxHwMF
	h78qNn6iiFBpgPG3EWk3Z9uT4gUQCFnTZEgMaQ0IxRY3eoyXnEzVDaKGQQChDy72bw==
X-Gm-Gg: AZuq6aLcMocZMFnpjSamYK8kaOivKowoHlfM+cCeYY4lsKjrcpVH0kfAyK7uDBFFjqs
	jMvMNvFT8mHxMq7koY6bBGwnyJ1ymRKLbMRID9xme4xbtzETvQVhucQmlbr5nF6B/C0IVnFSCfu
	MMePK8bwjEhCULHeK0H1OqBQ26DZEXcWpJRfgC9GkaH/IQO0smqHMV/XKZf9hVM7Zf5o5VjaKyB
	qah8UbwZ0Sv+FS3P1k7zwMk074+dcoavsApmmDsjZ3dkvmgBczv7vv68kP4IvckCsTAGmhuagQw
	jYTUifHrrIZ6ALtdU3JqAZ/IXLoIGO5+HW7Xa3ONdJbViXw95arxJerZz8e0SMs2Cp6hRXRvQ8f
	ZO0aamWZ8N2zpe2hKFBSTNN/BTVDtkiw+DxmthtANr3FDgl4ZbOHAtyoWUTGcZ/jwPhmZXjCV4H
	hnrKo0O4bok6m4IoEBa9WI0zUqXPjfpbW7s3kgG9QX1M9oplKE28yoWB3HWc1b
X-Received: by 2002:a17:902:f54e:b0:2a4:8cd:c3cf with SMTP id d9443c01a7336-2a951926c4dmr113415405ad.49.1770710567252;
        Tue, 10 Feb 2026 00:02:47 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:3f6:92b2:887b:120])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c50206sm124298085ad.19.2026.02.10.00.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 00:02:46 -0800 (PST)
Date: Tue, 10 Feb 2026 17:02:42 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Doug Smythies <dsmythies@telus.net>, "'Rafael J. Wysocki'" <rafael@kernel.org>, 
	'Harshvardhan Jha' <harshvardhan.j.jha@oracle.com>, 'Sasha Levin' <sashal@kernel.org>, 
	'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, stable@vger.kernel.org, 
	'Daniel Lezcano' <daniel.lezcano@linaro.org>
Subject: Re: Performance regressions introduced via Revert "cpuidle: menu:
 Avoid discarding useful information" on 5.15 LTS
Message-ID: <ioyakugzog4uecwugy4b5ysxdimvh7qtosainou37rwp5bpoks@5csx6sn7ziso>
References: <CAJZ5v0gcSb_6QPMfHkjSMJ6OOF+PaCZrUKOafYQ++tHE2jBB4w@mail.gmail.com>
 <3b0720d2-9b72-48d0-998a-1fd091cec44f@arm.com>
 <5d4b624c-f993-49aa-95ab-5f279f7f6599@oracle.com>
 <8fd5a9d4-e555-4db1-aa02-8fe5b8a2962c@arm.com>
 <3395ad0b-425e-40f5-844c-627cff471353@oracle.com>
 <3f0cfac2-b753-413c-9a7e-0892c23cdbf4@arm.com>
 <CAJZ5v0j+jfTHog+rVO0816mofk7nSSKCt7dbwSa2QCpYSN013Q@mail.gmail.com>
 <005401dc9638$b3e2ea40$1ba8bec0$@telus.net>
 <m7pzdjfjcm2gr4gpru3rk26o2wn5iarihff6kz3o7n3slsvonx@k6jkyemuywgk>
 <29b3287e-0a08-4648-9e54-32889c99b1e3@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29b3287e-0a08-4648-9e54-32889c99b1e3@arm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215616-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[senozhatsky@chromium.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:dkim]
X-Rspamd-Queue-Id: 3DBE21181BD
X-Rspamd-Action: no action

On (26/02/05 07:15), Christian Loehle wrote:
[..]
> @Doug given this is on Chromebooks base=84.5 and revert=59.5 doesn't necessarily mean
> 29.6% decrease in system performance in a traditional throughput sense.
> The "benchmark" might me measuring dropped frames, user input latency or what have you.
> Nonetheless @Sergey do feel free to expand.

I'm not on the performance team and I don't define those metrics, so
I can't really comment.  But frame drops during Google Docs scrolling,
for instance, or typing is a user visible regression, that people tend
to notice.

