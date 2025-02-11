Return-Path: <stable+bounces-114924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CA4A30EF5
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 16:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F256C161FFB
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 15:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EC63C3C;
	Tue, 11 Feb 2025 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="G+YuShq0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B3A1BFE00
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739286040; cv=none; b=oEaHmPkQUd1ZJdomB+1NfEYhNN7cgbLwBTj+JZJ/sg2zBxcF8ceFOqt1cQdVtZsdjkOe6CY+sGxAd1sytP/caRQeTFH7m5fOrj454k87wTYrmHm6hZsKT+7aaJdeqB44FNcjT4FKqQTYynWqrk5U6+3GLEmTFW9VHym3KNtF+2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739286040; c=relaxed/simple;
	bh=SeZXqD8JWP8+YkkdqOiQWlBUXaWI92pR/gJ6y/3u2fw=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=c26vK7em+oKU5L3ppagcTtkTHqu9DdITthp3khUorTqgCEf6kAg5ADYXRixOJAwiTqCMQLs8eD1kqXAz2R614pwKUeVCURKOFEwQefucro8J0FAtjXk1LbXh4lMRofQpGj3AD8xPN+HXPgw0EmlXPXbW3webjwj4gZdyB9UyNdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=G+YuShq0; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab7483b9bf7so831044866b.3
        for <stable@vger.kernel.org>; Tue, 11 Feb 2025 07:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1739286036; x=1739890836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2iIJTUvgaxQC7B9JYhBC5NLUyJH1I18DyZt6+q2EZ94=;
        b=G+YuShq0gohoWiq4TSDEtBGYSSF3OG/jo+pwJ1W5heQ+XuRvr46SwIpGYu/Cxa5TPa
         F2fZN/uDagIKxlHJbLxpRR+Fjv//qKcCmSD2b2FbBkHMbAK8aTJD73a2c04R7/xjMmXj
         MKhbMS1b7Mi6uef6CLfaFflyFCJHZj769O+eOjM09oL/ceUIKhmc1GfoDdb+ShlwoPXz
         dvOapAO/TRJcdgV2tzWEV1gzwuH88VFpzdlAGs/q4G/eqSAMBrcCBldbxondEq7Acl3l
         nId9o/Lpe7KGMo1rk1hhKN48EarMxaPu0pn1XTvbjR2Rsip7VezpPZH0s0bsw8E+hGPg
         Ln3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739286036; x=1739890836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2iIJTUvgaxQC7B9JYhBC5NLUyJH1I18DyZt6+q2EZ94=;
        b=fHVJ74JAvD8tXQ6Y44Mgrvy17ks6RTxgQycEObg5LxxFrDe1dF28FdPtjRO9D7NQM3
         X4uXW02kySJTaGk5yfM3D8/xREE1p2Gb0v3rAakgvNjWn0HDBlOMRzIO07PelflkB71x
         wmyxFBzu1scN9WRJ4wI6SrlsRA/J0bP8VSOz2WglEz8X/k5NOH6gpgdarojIxyGWlfa6
         fN8tlHsBYX1gNwJDvWtjz6I3+HDX94s1N/A6CHUeuaTsJcmPeRxcc0bJghlcHuAHc5/8
         VcRGZw4lrZACDT2jh5bqNJsTHCELEnBVfUD3vyhFIkLidwJz3+YOKmeuIIDg1Pu5micl
         xJGQ==
X-Gm-Message-State: AOJu0YxokuDLxRP8jrdUNLiIFZvaAG2LbjW4lO6bPwb4d4rdKAuJAFl3
	wm1eQKbBFvz4ZWaw8U2xjl+s32285fQMHaV3kTp3jeTEC9tVEhI/Qv+nmemIYBDJoQThzH2A3DF
	DpTqXP4IWxCL7e/fd9VKpyAE8v32wu/RnW5JbvEv0unA69GNplwA=
X-Gm-Gg: ASbGnctQPe/jp1wV4xZnkv1vkTOr/8wicI7F91166mn2cW/XbK+71VBgOPryiz1vYl0
	uIJfblHtzSYg6YSk0mt/RTUidvnxw1ILMD9UACCDiVDOVn0htlwAbnFbxA5da2tjgp2OJbaaXsf
	nEvmc5N1Qju+s4L8v1WvHcUxOZwgGstQ==
X-Google-Smtp-Source: AGHT+IHV4brUuU3wyKx1JMyUnDKqyDUkAWu93EeWlkABmBALpWhYE6gfwomNFmgxUpmy89IkxxFVVHVWIfWA3Frpwk4=
X-Received: by 2002:a17:906:1912:b0:ab7:db71:2975 with SMTP id
 a640c23a62f3a-ab7db712af5mr278676466b.31.1739286035769; Tue, 11 Feb 2025
 07:00:35 -0800 (PST)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Feb 2025 07:00:32 -0800
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Feb 2025 07:00:32 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Date: Tue, 11 Feb 2025 07:00:32 -0800
X-Gm-Features: AWEUYZlRdFyToYSBAICQNe2ks2XGve-u7x9t5TtvKfvvKcXP0F56VafPj-dChkg
Message-ID: <CACo-S-3iUESsZkX8UXEC7b06mStnb9D4OTN0uiH_=xvq9Ue3EQ@mail.gmail.com>
Subject: =?UTF-8?B?c3RhYmxlLXJjL2xpbnV4LTUuMTUueTogbmV3IGJ1aWxkIHJlZ3Jlc3Npb246IOKAmHN0cg==?=
	=?UTF-8?B?dWN0IGRybV9jb25uZWN0b3LigJkgaGFzIG5vIG1lbWJlciBuYW1lZCDigJhlbGRfbXV0ZXjigJkgaS4u?=
	=?UTF-8?B?Lg==?=
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org, gus@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New build issue found on stable-rc/linux-5.15.y:

---
 =E2=80=98struct drm_connector=E2=80=99 has no member named =E2=80=98eld_mu=
tex=E2=80=99 in
drivers/gpu/drm/sti/sti_hdmi.o (drivers/gpu/drm/sti/sti_hdmi.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://dashboard.kernelci.org/issue/maestro:c489b0f0574bd3857=
9af0eba0ab35e7b2e49d000
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  fbe69012f6c01a2b7fea011bfad0655f1d28eea5


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
drivers/gpu/drm/sti/sti_hdmi.c:1222:30: error: =E2=80=98struct drm_connecto=
r=E2=80=99
has no member named =E2=80=98eld_mutex=E2=80=99
 1222 |         mutex_lock(&connector->eld_mutex);
      |                              ^~
drivers/gpu/drm/sti/sti_hdmi.c:1224:32: error: =E2=80=98struct drm_connecto=
r=E2=80=99
has no member named =E2=80=98eld_mutex=E2=80=99
 1224 |         mutex_unlock(&connector->eld_mutex);
      |                                ^~

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-12
- dashboard: https://dashboard.kernelci.org/build/maestro:67ab309ab27a1f56c=
c37e0b7


#kernelci issue maestro:c489b0f0574bd38579af0eba0ab35e7b2e49d000

Reported-by: kernelci.org bot <bot@kernelci.org>


--
This is an experimental report format. Please send feedback in!
Talk to us at kerneci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

