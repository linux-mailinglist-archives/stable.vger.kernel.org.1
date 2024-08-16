Return-Path: <stable+bounces-69328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD93A954AE3
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 15:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99718284470
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 13:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADDC1B32BF;
	Fri, 16 Aug 2024 13:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=hotelshavens.com header.i=admin@hotelshavens.com header.b="nFlAyZfU"
X-Original-To: stable@vger.kernel.org
Received: from mail.hotelshavens.com (mail.hotelshavens.com [217.156.64.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6AE1B0122
	for <stable@vger.kernel.org>; Fri, 16 Aug 2024 13:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.156.64.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723814460; cv=none; b=DVkuLUTRbGwErWyVqzhUv9elUSLjDtof2Ey0nVqrUnL5Uota96KuYXqTumUWX1NwYsBHM8XaN24kHy65LvE3z0K63R+uo1unFNbDBj6vVPQY5No+iPC8S5X0W+4A/AExwAmqZeR85fOo5E/h4StyhJcD5SfqgPacubOOTNb1AVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723814460; c=relaxed/simple;
	bh=LeauVVj/ho8MTPNMawrJjqTY1r/703ALfp3CIgRyk7w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XUaunOQ6GKuaMBrae7KSgz1NRJOl4eTLE+5XTtUzaTFPR13+Vdk+12Oh4gK0+r/q3eeWa9qzEbAkv+7WpRcFAh4JNUX9Gn3oQd6utq2eJT0gCHBV0wX398ZSewOgzVJeWzfSZ11DYqj+3/REzNvyuTJE+6W5drSsgNL1Zg6Etis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotelshavens.com; spf=pass smtp.mailfrom=hotelshavens.com; dkim=pass (4096-bit key) header.d=hotelshavens.com header.i=admin@hotelshavens.com header.b=nFlAyZfU; arc=none smtp.client-ip=217.156.64.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotelshavens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotelshavens.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=dkim; d=hotelshavens.com;
 h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding; i=admin@hotelshavens.com;
 bh=LeauVVj/ho8MTPNMawrJjqTY1r/703ALfp3CIgRyk7w=;
 b=nFlAyZfUqeGzlj0KZi9zotknYIT7Pau2Pu56dJ1R6f3sG2R8YqnznmTt0xkF6LdgbjoKdqykBq7R
   gKCMv/Y2+gWxOv1A8oSpjoS8+3JtBml4F/BwH5sXHxZKeJkjVgS8vRGKIe4iWHm6f694rUCxYgTt
   Zi+/8QU4SH6GeGfPzVgBqX44oAOBLl+/gqVMvEPSI6BNdSmSArF2ipClQC82PVkIAG1BmZIqsTp4
   mlDXjZZiTH1nwufD7IiGuZTjPHJ/iX2k8vmTGz98MBLIz/A+JPicRnyMAQrv801ec55GSyPkKJhw
   qYj1fI8NgDE2DXQXbiUMlas5pc4CUPAx+k/v1Jtr4+Uu7OIyhJGby/WAaRBngdfAm3vw4UQxXdSy
   Nx7HePkO5f/YR45NDHbercJff1BN8+UnAMKiT762DbI2KCAprwZT7a12RPvQenSSD+18vRPiQf5O
   gUYpJ5L8pscJfNtjTvzQNorj0A03Ybj1v8+r10Xhf7t3pfLvDZuq2/DKoP3GdncokSVNNXA/rVT8
   oaclB88GhSwk/CVB/DUuQZ3TzRAjK9rjd7pLemho4HylhvBOOEJQ074iA7F0JzNmydWMOpWA/6oM
   1hSlRW+mtiQFLOaogRRYH0bAf4b1vN36lCTEbMhRG0JaZMMbzB/4vgjvMHlWsQgqeTLYuLxNJng=
Reply-To: boris@undpkh.com
From: Boris Soroka <admin@hotelshavens.com>
To: stable@vger.kernel.org
Subject: HI DEAR !
Date: 16 Aug 2024 15:14:23 +0200
Message-ID: <20240816134828.C40C0057EB67B0B4@hotelshavens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Greetings,

Did you receive my last email message I sent to this Email=20
address: ( stable@vger.kernel.org ) concerning relocating my=20
investment to your country due to the on going war in my country=20
Russia.

Best Regards,
Mr.Boris Soroka.

