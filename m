Return-Path: <stable+bounces-112187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F01E7A275E3
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 16:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D62C18872D3
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 15:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB3C2135C3;
	Tue,  4 Feb 2025 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digitalmanufaktur-com.20230601.gappssmtp.com header.i=@digitalmanufaktur-com.20230601.gappssmtp.com header.b="enstak1z"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9992144D2
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738683120; cv=none; b=SZOAzdc/jbtipc/ujSPJ8vcSpni5LZSQVwpP3c8Aguc2TfQWHTexU48FH0e6YpjtZQwuA8UJzvIrWxwSoLplqsZIGtd/6q8zqTUX+ZMny7WqMhr10ODMYO7sYb1gjrzcWxmYM8DWzFmxg/QEsDYgAmuoTCsmOOlC5BS5t9ZS5IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738683120; c=relaxed/simple;
	bh=r9877E0RyLUlUr2xFl8WZSypTY1T6G2NwPYki14ZACw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dJukXYK4hysuLynebn0uPLMSJU1zPV7rXhlYdusx9voljSu5dyIwtMzmsMUXo0pA+CVaOC66JiGN269i9FtbC2xwdF2jJqP7nSY+vCqNyXwNNvRL8nkPGwBSJhIU902psAYP9HIzAYRiNuw/ytsNLetqKT168Zvqt911GXw6elA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=digitalmanufaktur.com; spf=pass smtp.mailfrom=digitalmanufaktur.com; dkim=pass (2048-bit key) header.d=digitalmanufaktur-com.20230601.gappssmtp.com header.i=@digitalmanufaktur-com.20230601.gappssmtp.com header.b=enstak1z; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=digitalmanufaktur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digitalmanufaktur.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso1180348466b.3
        for <stable@vger.kernel.org>; Tue, 04 Feb 2025 07:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalmanufaktur-com.20230601.gappssmtp.com; s=20230601; t=1738683115; x=1739287915; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r9877E0RyLUlUr2xFl8WZSypTY1T6G2NwPYki14ZACw=;
        b=enstak1znjPzSIAqtf6fidvvn2bJ+UYDIDCCkhcQAyIJVBYUm5e166VVYFv1PlOokj
         8DX9NgkLx0dRrJDZQh+GGe1i4Zu9W/asS7zUK1ihSaq1CL0zbvKo24VoJl0nS7T7XydG
         6J6X+GnX1Oz8sE3jLS9FKltkRhC0+cWsjK7C9koTaFsS5F8gmNUB+NRCdjJhNfuLyrUA
         cEHK4ND6O51i2dIKkCht0ydwq+z4WB3dBAmsykMSeozC/OpBEathZWoGgLKVy1vWpoph
         OvZSumbN9IQlHzao+GHfaemk3lNosIavN8uamVLNd/OaK0g7EpOHrMNashgX1d9HdC2d
         MtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738683115; x=1739287915;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r9877E0RyLUlUr2xFl8WZSypTY1T6G2NwPYki14ZACw=;
        b=deFWhbtpZGWC124Cv2YZpx+KD30MEWMKEBjV3lBxAx4QOkThB3LIqoGM/mQlF3L+WX
         r3/BUOqy/m/foy69VgheHxcwsjmW53+oNiLYU4Wy2DmpnNyLABQptBp19fwqZ4ew2cav
         YQ9rCTxbTRlnjSWqdqUE2ztfI71Jv/o0O142B5cjYBOn0YHRx5eovOctb/Mqj9hbRi0L
         vNi5pml5pI35N2tZIExef1qZwwK1oE3hJf+hGdSdzVoxkSg3aziUkm5GYGrj6FXDY7WG
         6xLQlZIjrGdGooeAc+MfELVyfg1IQdc57iBLZt1szQWsaRdzXYMlaZq5fkWSXzyHkVea
         3ZHw==
X-Gm-Message-State: AOJu0YyPw+5NutT97DpBqhPTzb7GKAh5JF9ETiE9mN3XYgGq5F2Sxf8z
	EHSXrVtJ5mWECttphAmlymwbo62c8VEMBQoKI2lWiL/fdu0GZUvsspiOnD+Jft5YWvBWbI5+Fbo
	RTYEvQMD6r0q3RrRAFywFzEmU8Bjr1diwvJNDsVU7APchBsWfPZ8=
X-Gm-Gg: ASbGncvZkAPkLjtrQ3uRwRouQbU2DYH4mkKiD+Fq2mxZ8dCWZBSDImtVDC3jn7Z7z2t
	5lgQJDdzmngnW9QQ87DIPXDACy0Fc//qSa+Oqr/8zs2NyjeS/M0St9QopWEbYmZpyvMbVq0Cd
X-Google-Smtp-Source: AGHT+IH3AxE/Y21XQG2yB7PKD1cjKJcA+YqVh14T5X8EdlSRmAwJDPnrm39WyHw7xFkkjx1j/hFQZC08EjJaSsgfC9I=
X-Received: by 2002:a17:907:94cd:b0:ab6:3633:13e with SMTP id
 a640c23a62f3a-ab6cfdbd071mr3424739466b.41.1738683115180; Tue, 04 Feb 2025
 07:31:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Kramme <kramme@digitalmanufaktur.com>
Date: Tue, 4 Feb 2025 16:31:44 +0100
X-Gm-Features: AWEUYZmPVZO6mato28kpaHXOAaoQrsiaiSxG2ter5xopyYtbfZuMaIjSmdGKB2I
Message-ID: <CAHcPAXT=6GhKo4CnkveSm_X+EQXSz-GCRtigi5aFRscASSTFXw@mail.gmail.com>
Subject: v6.12 backport for psi: Fix race when task wakes up before
 psi_sched_switch() adjusts flags
To: stable@vger.kernel.org
Cc: chengming.zhou@linux.dev, Bendix Bartsch <bartsch@digitalmanufaktur.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

we are seeing broken CPU PSI metrics across our infrastructure running
6.12, with messages like "psi: inconsistent task state!
task=1831:hackbench cpu=8 psi_flags=14 clear=0 set=4" in dmesg. I
believe commit 7d9da040575b343085287686fa902a5b2d43c7ca might fix this
issue.

psi: Fix race when task wakes up before psi_sched_switch() adjusts flags

Thanks

Paul

