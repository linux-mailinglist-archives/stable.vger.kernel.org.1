Return-Path: <stable+bounces-69774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C34779593D2
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 07:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB90284521
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 05:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BF614C587;
	Wed, 21 Aug 2024 05:07:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348621803E
	for <stable@vger.kernel.org>; Wed, 21 Aug 2024 05:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724216827; cv=none; b=cQC5qN27125ZZkspfGtOf9nYQfcj/W/LpR+9VGIKtdYI1ZKo+rjlyOMOUO+GVKMxltZ0mhEHkXdFlNjjsR/saLFSmgVS+FCEzGZjIYxuOSNRyL+LhiujtjGMbgsAXtkhg+/YzVRXQvt9bFwGu9FxWVkt4TyiH0JJwOg9ZGWPp1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724216827; c=relaxed/simple;
	bh=WoPEOsz5xZt+WLZSs6pAQ4cdW7C4F2qDj2ZqJjvcRm8=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=Mr9G2OKdXSfXG1pKv6/YhjgV973IBP484Eo79V3Vd/JxWTeycOiTV3CQ+enf0Onuc3D6lQRyhC9FAq8VCGT+0RPU3JsxJLe6Bz66Lfs3EUcdhCeRLrpGmJ1EDRjLEHctxhzAQhxuc+5PWa+AqfYvCJXeM14I4DHuTFLS8vlGcnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b69d44.dsl.pool.telekom.hu [::ffff:81.182.157.68])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000074B56.0000000066C574C3.001CABC3; Wed, 21 Aug 2024 07:01:55 +0200
Message-ID: <c8c0cae77c2f9c0a4c103b30dcda34e5ac10f820.camel@irl.hu>
Subject: Patch "drm/amd/display: Don't register panel_power_savings on OLED
 panels"
From: Gergo Koteles <soyer@irl.hu>
To: stable@vger.kernel.org
Date: Wed, 21 Aug 2024 07:01:54 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Greg,

I think commit 76cb763e6ea62e838ccc8f7a1ea4246d690fccc9 should be
applied to 6.10 kernel to disable Adaptive Backlight Management for
OLED displays.

Thanks,
Gergo Koteles


