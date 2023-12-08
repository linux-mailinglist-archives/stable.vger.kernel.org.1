Return-Path: <stable+bounces-5049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77ED380AAFD
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 18:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89E61C2085D
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 17:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB1E3B2AC;
	Fri,  8 Dec 2023 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwcEHitB"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5D6173B
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 09:40:29 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1faf46f96ebso1317614fac.1
        for <stable@vger.kernel.org>; Fri, 08 Dec 2023 09:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702057228; x=1702662028; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+wiqlfHTAclqk8v15sDMZMSxDnzkIj9RnW82oBEpJls=;
        b=LwcEHitBbsicRwYiTW/jFDA8zL/Lb9QLb82NZEZtC4rI8tY59qx4FObxQ96K+CK4Sc
         I3UuaxyIWtua+BRFKzLDkDH28xtcdahgJeKAuro13uY2rLsuwFdr3HRFwTDu+S5yViG3
         FyVKA9Kn5uRCXcDLoKLu+iagUHJEekRhrnT7akgxXy1N64DK/MiR0wLKbxe8PX9HZ/me
         +zWcqwfd0fUU3ym2fjrZ1hgvgbckIJhNGw99rjyuCbls6UthbJyTObZNwQvzsmpw0QWn
         2zqgjAgRS5jMZoXTRQbxOqSHg7g3ZOy8Q00msALwFpEK8qdrOhRIaDq1yjOaockY93+Y
         E8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702057228; x=1702662028;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+wiqlfHTAclqk8v15sDMZMSxDnzkIj9RnW82oBEpJls=;
        b=R4CnqHCXmawrdIykNNTcbiXH71V1fimMAVH2v45Vdnm26bhazxLPf7T05EFEenArdQ
         20CR+UrnBl6tCHnIGj7nb+Wto2QD/fb2T8/OxH31+4lmD0utii3zxG9cTaFQaGMtfjb8
         S+qT8XTUPPlwxKAfWgBEHl+fey2kfcQI8xGdhOt81zpGw26To3n18ZkTb3GQWIzXF5Mc
         MvsvQxoVHSIh9R3uoQdl/m6UzV2tlD0b2Mx2kNHD3HK9tdwRZ5vniSyCjrTphOShBX2m
         d4g6BarVXHTnhF4AJA3ujJlcdhQ2vSHL35zFrg7z9+6LZglmfV6wpLK1A+g8HNOeNICM
         G9HQ==
X-Gm-Message-State: AOJu0YzBD4jf2jZE1O8cgqOs+f2/yFJ+SRAof8a5BU3ny7buSTUmngaO
	41Z5BsbO8E25+jOeqH9luK7ZWaYBcIJq2S8qWTU=
X-Google-Smtp-Source: AGHT+IEZsUJnpw/GPNrkSZndlY3+84CUZ884gaNOzF4sOjzLmxMRT87KfOC0I1jQiPIIimKWtcNDsCjBznw5ggDKGgk=
X-Received: by 2002:a05:6870:b012:b0:1fa:e541:441f with SMTP id
 y18-20020a056870b01200b001fae541441fmr457860oae.27.1702057228459; Fri, 08 Dec
 2023 09:40:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Dec 2023 12:40:17 -0500
Message-ID: <CADnq5_NJSb0+TNdsFR2hGji53AOTwzoU7vjh6+r58gjAT7xn1g@mail.gmail.com>
Subject: amdgpu fixes for 6.6 stable
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg, Sasha,

Please pick up the following upstream commits for 6.6.x stable:
commit 04cef5f58395 ("drm/amd/amdgpu/amdgpu_doorbell_mgr: Correct
misdocumented param 'doorbell_index'")
commit 367a0af43373 ("drm/amdkfd: get doorbell's absolute offset based
on the db_size")

They fix the following reported issue:
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3007
Fixes: c31866651086 ("drm/amdgpu: use doorbell mgr for kfd kernel doorbells")

Thanks,

Alex

