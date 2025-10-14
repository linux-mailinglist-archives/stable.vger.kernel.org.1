Return-Path: <stable+bounces-185668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D12BD9CD6
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 15:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B2E44E9038
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 13:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328122571A1;
	Tue, 14 Oct 2025 13:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZZURML6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E279A18A6B0
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 13:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760449640; cv=none; b=LQdOpiBZsgNyOviqszttBpBp9Qju+C45sEI2WWswrvmsVl2CIrt8zgvaOOCwytEhF/MX/N90rco4mIMuXAKlbfAEGt5cnPgtC3Urn97PUjRjLnAccGC5tAzM4Xrc+2MP3hinsVTbBjD7aZ369l0kcxVUunCA6603qAnEy7fx9q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760449640; c=relaxed/simple;
	bh=FiyH3HbysJHIUya6HD8TWJH15efuCVgzlLJ6VhuzQDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yi9+2SDtcty6BBDWZIhgF7I5cmnU6/0pQjnBxpUZUelUxp+8MRDE7La0K6nybJNIThCKZxeoGCs+PINup88r5oSZF+g5UbQ3UZEF+DRhLMqFL+7DiInw7KCLOJAs0Syh0bTD4Zjo8ABREjdLE/+rO4gp1rkToGZavzeuSSmJOX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZZURML6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849BDC19425
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 13:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760449639;
	bh=FiyH3HbysJHIUya6HD8TWJH15efuCVgzlLJ6VhuzQDs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VZZURML6hVuzmSChY5ByDgxyVVw95GXY/1dlNcW0WnkqJjc52ZPgL/r1NczJ0I/k4
	 EHgmRoU9b6E9LLfG9i0FbRBR91L8PqfbzmBGrG431fMC9JvR7SzicgEk6VY4R90VV6
	 Y5pmSGxh2wj7ygfgxFdiCJCJ/DypLLwjRtgt/Tw9p1nufVNw9WdjXdxwcXQdOcrSwp
	 G2AUX4ZTFRqi3LNjmyRnHK3lTyD3eXnlSBVs2sUihIUPLjNKv7OJpCeUIzHIwr7ehk
	 DSNjHK8gBhZh5NGbYw+fqvokYMyIXcUxx4LNTfjjFRysZk2cgS4Wh87RhiS4YjXYFZ
	 6U202kW/zAlsQ==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7a32c0163bfso4338486a34.1
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 06:47:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYVLeLpNI8qP9PjLtOOciy5bhazgMXrixUtkqAao0BgjsCQ8d3WWkOWRPU6MZJlHRbDXX2H8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzljkqbnCo/x9/ZfO2YpoiVMNgt2PS6LDaULIxmAC4WTHumgsru
	9NxKzPAh7mr06bQvGPMSYHhAedUPaENEmdczxsgiHSCXQ8XvlN71HVIJWuT+JupNx7xy+HPH/Ts
	sA0zVb8Zp4W2o3rg9NKyOGKPFlGMPmxQ=
X-Google-Smtp-Source: AGHT+IFKdZN6ge3UA9PmzHlP2xLrNNqxW7vEeMa7BKOK7ktylhLXEl8XSOWc6vfk0wQTHsMb6jpquijdfDXJa+k9Sqc=
X-Received: by 2002:a05:6808:2028:b0:434:ef1:568a with SMTP id
 5614622812f47-43fefa71ec3mr13128919b6e.0.1760449638648; Tue, 14 Oct 2025
 06:47:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <08529809-5ca1-4495-8160-15d8e85ad640@arm.com> <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
In-Reply-To: <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 14 Oct 2025 15:47:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h-=MU2uwC0+TZy0WpyyMpFibW58=t68+NPqE0W9WxWtQ@mail.gmail.com>
X-Gm-Features: AS18NWDOTKJOUDRsGacceCYS3_zrSEM9Fs-sfsGd6d-Fu57AFnPpu7CbKcyjsmo
Message-ID: <CAJZ5v0h-=MU2uwC0+TZy0WpyyMpFibW58=t68+NPqE0W9WxWtQ@mail.gmail.com>
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Christian Loehle <christian.loehle@arm.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 12:23=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (25/10/14 10:50), Christian Loehle wrote:
> > > Upstream fixup fa3fa55de0d ("cpuidle: governors: menu: Avoid using
> > > invalid recent intervals data") doesn't address the problems we are
> > > observing.  Revert seems to be bringing performance metrics back to
> > > pre-regression levels.
> >
> > Any details would be much appreciated.
> > How do the idle state usages differ with and without
> > "cpuidle: menu: Avoid discarding useful information"?
> > What do the idle states look like in your platform?
>
> Sure, I can run tests.

Would it be possible to check if the mainline has this issue?  That
is, compare the benchmark results on unmodified 6.17 (say) and on 6.17
with commit 85975daeaa4 reverted?

