Return-Path: <stable+bounces-11794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3148E82FC5E
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 23:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE471C27D81
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 22:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613772510C;
	Tue, 16 Jan 2024 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJSZDI+U"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93DD2510D
	for <stable@vger.kernel.org>; Tue, 16 Jan 2024 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705438229; cv=none; b=BAaj4zIvEdKkzN27c2VhXKDR09gWABcx9L+uVRYjs5MnB1M9YRUl3cUU2ufdStLPQLMTPKd0NgmRdtHgIak1BQJtj5Q8QxU6VjNBMlJYMdnsXKEbSsCawINQEmI1+R8r+t/ZQOadBvCBzHHV5e/35yK6NrMnqY/jSmaxbkVhEJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705438229; c=relaxed/simple;
	bh=nG0tvbZeAMvpToBrfiYjUnytBafjXDKbT1OWSnM8wDk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ePILiLUP52HX7qs8xg7rRp28kpx4eKUK9leFbV4lkiouXw8MDkSHF1zzZWqPhvUl/xY6rUdY7mmZN4TXa0Stz3fDRDoswnYktzxvXdwjXAiNgi9Q+0r2e9ngbQEdST5OJ8fefz4KD+/gtCO6seXadjNm7mZ0268CUu91xwJsfm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJSZDI+U; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2dc7827a97so304978266b.2
        for <stable@vger.kernel.org>; Tue, 16 Jan 2024 12:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705438226; x=1706043026; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nG0tvbZeAMvpToBrfiYjUnytBafjXDKbT1OWSnM8wDk=;
        b=UJSZDI+U1grSVLcAr8/jPPuGJBaiun8qEhPASU4mmH6HWbKi3hqLnchSVjqrCpFeA5
         o1LrPbe36XHcny0Z6DKwqnZkBW0L1oLAx6xCJy90UAkxzfnifdQ4f/m9jCuqzojbyxbr
         JqhXte7hjHf3Hx1zn5ZkwMMdOyW/1hUGCubG9HUYaysioncpmuljoGg976F/YKXpPe1t
         lz/FcVseAH67ORz49fDg5WKFvjmDBn3v5Rt5OL4QDbQF4cqvASV9pMYCw/FJqNzDDI4q
         JglneTAOtMTyUDuEdZ3fh1cD5KVRk+cbxnB0xY6zioEuLLbfuzfIusMx0bN9asQjHpOm
         kQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705438226; x=1706043026;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nG0tvbZeAMvpToBrfiYjUnytBafjXDKbT1OWSnM8wDk=;
        b=RhgtCcVgQt/0pgF140xvcX/siaGcLKbYDR4RG3PFO6YetK2O7BUOEby8kedEGc9NYi
         nhQUT8zPug7JN8UmhzXk7MnA8/gTM9PpsrI2UP+EHQUuXKqn1cEThU/wpcN7NhRvxlvC
         PHVzkDbzMqa1LizplxnUDbvRpHYBJjoY22Wy9ynskwB3QFfaRoMyrls9hw2pfgJZbqMK
         wqAZJyeXAh6Agi4CMC2rOBfk8c3WYso3cR4PF3oUDsz2Tf2r/QCbi1KKVZsP8qpsUTfQ
         SL2D0/dh5CZZBl9X4QTL0dMXpyLAALsd2qxGfvL0HuaWuoblh1RwQ6VZuViEugW4qnGZ
         4HNg==
X-Gm-Message-State: AOJu0YwwTVjJZQJkJV74rDyqvOPSx8VRLN2I9NS5GyFoJQ9/dC08NAED
	NH4Egk3LzNDJC/3XcAvXpmW43f+NBxeO1u2EEu3smKvxjTM=
X-Google-Smtp-Source: AGHT+IHf9KTGzlro5W5MYDrRgLauo6KPQrzRN+/p9Cob3n7vxnY5Ww+00GGzKJnI2Oab8wsNGgb045+0hkYzm2UQd28=
X-Received: by 2002:a17:906:1106:b0:a2c:179a:f6ce with SMTP id
 h6-20020a170906110600b00a2c179af6cemr3681951eja.96.1705438225532; Tue, 16 Jan
 2024 12:50:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Serge SIMON <serge.simon@gmail.com>
Date: Tue, 16 Jan 2024 21:49:59 +0100
Message-ID: <CAMBK1_QFuLQBp1apHD7=FnJo=RWE532=jMwfo=nkkGFSzJaD-A@mail.gmail.com>
Subject: S/PDIF not detected anymore / regression on recent kernel 6.7 ?
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Dear Kernel maintainers,

I think i'm encountering (for the first time in years !) a regression
with the "6.7.arch3-1" kernel (whereas no issues with
"6.6.10.arch1-1", on which i reverted).

I'm running a (up-to-date, and non-LTS) ARCHLINUX desktop, on a ASUS
B560-I motherboard, with 3 monitors (attached to a 4-HDMI outputs
card), plus an audio S/PDIF optic output at motherboard level.

With the latest kernel, the S/PIDF optic output of the motherboard is
NOT detected anymore (and i haven't been able to see / find anything
in the logs at quick glance, neither journalctl -xe nor dmesg).

Once reverted to 6.6.10, everything is fine again.

For example, in a working situation (6.6.10), i have :

cat /proc/asound/pcm
00-00: ALC1220 Analog : ALC1220 Analog : playback 1 : capture 1
00-01: ALC1220 Digital : ALC1220 Digital : playback 1
00-02: ALC1220 Alt Analog : ALC1220 Alt Analog : capture 1
01-03: HDMI 0 : HDMI 0 : playback 1
01-07: HDMI 1 : HDMI 1 : playback 1
01-08: HDMI 2 : HDMI 2 : playback 1
01-09: HDMI 3 : HDMI 3 : playback 1

Whereas while on the latest 6.7 kernel, i only had the 4 HDMI lines
(linked to a NVIDIA T600 card, with 4 HDMI outputs) and not the three
first ones (attached to the motherboard).

(of course i did several tests with 6.7, reboot, ... without any changes)

Any idea ?

Best regards

--
Serge.

