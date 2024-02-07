Return-Path: <stable+bounces-19050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3215C84C6AD
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 09:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6D71F25BA6
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 08:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1049E208A5;
	Wed,  7 Feb 2024 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ruhr-uni-bochum.de header.i=@ruhr-uni-bochum.de header.b="wnziShKl"
X-Original-To: stable@vger.kernel.org
Received: from out2.mail.ruhr-uni-bochum.de (out2.mail.ruhr-uni-bochum.de [134.147.42.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF63320DCE
	for <stable@vger.kernel.org>; Wed,  7 Feb 2024 08:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.147.42.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295991; cv=none; b=Gi+eV5ddfR92+4ooPal9EtyKjW+tFfCN4FqU9PeOUO9MgLi3U6tNtU5625oE2542Z2M+Qln0LkoDqAPym+EhqC3CS3Rjo1lRMyUg8ugkEv0zxbMw5x7Bp0mqPm4XY6wT60Z8HvGEOirmu5KOdCZ2968EkVR5UEzKjhMyz/W0qOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295991; c=relaxed/simple;
	bh=Nqjae/cWetQpcf/giuDlO3b4XDHpmSWiARP+pn2lJdQ=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=qDj3UL8EYOi2/QADXDw0FAILlZZ1g3HpRg7eunm8PqEZTZ9LtezLwPuGy07BHKXN4eT8Lh7vp2VUfTVoqOKzruAwMZuKxUvSObVjzAT8uLyN0IdwqTL91aPvcE7A7PeeZ7okwS+cLukOObLwZUNxI69QD2AinKd9YPQlGB8D3ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruhr-uni-bochum.de; spf=pass smtp.mailfrom=ruhr-uni-bochum.de; dkim=pass (1024-bit key) header.d=ruhr-uni-bochum.de header.i=@ruhr-uni-bochum.de header.b=wnziShKl; arc=none smtp.client-ip=134.147.42.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruhr-uni-bochum.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruhr-uni-bochum.de
Received: from mx2.mail.ruhr-uni-bochum.de (localhost [127.0.0.1])
	by out2.mail.ruhr-uni-bochum.de (Postfix mo-ext) with ESMTP id 4TVDGs1580z8ST2;
	Wed,  7 Feb 2024 09:45:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ruhr-uni-bochum.de;
	s=mail-2017; t=1707295557;
	bh=Nqjae/cWetQpcf/giuDlO3b4XDHpmSWiARP+pn2lJdQ=;
	h=Subject:From:To:Cc:Date:From;
	b=wnziShKlFaXMGOFxAeE9x+HqoccviX4Tr6WgxmSquE0xvyRiPJJJdQlj2BWkF3cNL
	 U/g/yJUm6gIYMy8987+U7eOgcGlO4KJAX4PdMzXT133ZCZfdXMj0Bm6PBLUraooyqa
	 rs5U4G5eqUmu5Ls5s/mxnsJrOb+GdX4VddkZHZTw=
Received: from out2.mail.ruhr-uni-bochum.de (localhost [127.0.0.1])
	by mx2.mail.ruhr-uni-bochum.de (Postfix idis) with ESMTP id 4TVDGs0VYfz8SSB;
	Wed,  7 Feb 2024 09:45:57 +0100 (CET)
X-RUB-Notes: Internal origin=IPv6:2a05:3e00:c:1001::8693:2aec
X-Envelope-Sender: <leon.weiss@ruhr-uni-bochum.de>
Received: from mail2.mail.ruhr-uni-bochum.de (mail2.mail.ruhr-uni-bochum.de [IPv6:2a05:3e00:c:1001::8693:2aec])
	by out2.mail.ruhr-uni-bochum.de (Postfix mi-int) with ESMTPS id 4TVDGr55zrz8SSN;
	Wed,  7 Feb 2024 09:45:56 +0100 (CET)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.4 at mx2.mail.ruhr-uni-bochum.de
Received: from [10.150.38.32] (unknown [10.150.38.32])
	by mail2.mail.ruhr-uni-bochum.de (Postfix) with ESMTPSA id 4TVDGr0cXVzDh0t;
	Wed,  7 Feb 2024 09:45:56 +0100 (CET)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.2.1 at mail2.mail.ruhr-uni-bochum.de
Message-ID: <38c253ea42072cc825dc969ac4e6b9b600371cc8.camel@ruhr-uni-bochum.de>
Subject: [REGRESSION] NULL pointer dereference drm_dp_add_payload_part2
From: Leon =?ISO-8859-1?Q?Wei=DF?= <leon.weiss@ruhr-uni-bochum.de>
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, Wayne.Lin@amd.com, lyude@redhat.com
Date: Wed, 07 Feb 2024 09:45:56 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

54d217406afe250d7a768783baaa79a035f21d38 fixed an issue in
drm_dp_add_payload_part2 that lead to a NULL pointer dereference in
case state is NULL.

The change was (accidentally?) reverted in
5aa1dfcdf0a429e4941e2eef75b006a8c7a8ac49 and the problem reappeared.

The issue is rather spurious, but I've had it appear when unplugging a
thunderbolt dock.

#regzbot introduced 5aa1dfcdf0a429e4941e2eef75b006a8c7a8ac49

