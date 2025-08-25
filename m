Return-Path: <stable+bounces-172891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A0EB34E6F
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 23:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127F618906AC
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 21:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECBA29D26A;
	Mon, 25 Aug 2025 21:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=msa.hinet.net header.i=@msa.hinet.net header.b="VK0zuFZ1"
X-Original-To: stable@vger.kernel.org
Received: from cdmsr1.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6957B28726C
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 21:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756158751; cv=none; b=NQSCeuGk5DY+4mR2agCYjMZh1THA0lO5yKEDyeTA7Edgxg+OxCth5ed8S9wLFtZNWgRXzBneUZ/jteDrSI0bRVrY/lIq+K12wdXjeM9fSaWed3VjPiNfA8a8/VB3SKFuJ2m96mVm3fZt6miwah4SBgIAolk4G1HXCw2lSl4pRLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756158751; c=relaxed/simple;
	bh=Z1MdS5Urfw7ePm/p1D4MrWWCnqc/pjXbcAkk0qAPJOI=;
	h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type; b=Sz2LwzU9hkSCF9g3EjTZco3a/T1ts0igG+St/oeDXz+LTHj3gQLOVp9wwu08k1AKMqmPYfLL/V01wlNZ8H9hiopAffJjLJfPtJ/My/x5QMtp5k8iNSKTqA4ovBvZ3+u+jr+rnriiHAdRhghFzBiJR/2mdeI6/4fwMC032GmlCnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=msa.hinet.net header.i=@msa.hinet.net header.b=VK0zuFZ1; arc=none smtp.client-ip=210.65.1.144
Received: from cmsr1.hinet.net ([10.199.216.80])
	by cdmsr1.hinet.net (8.15.2/8.15.2) with ESMTPS id 57PL1LW1589951
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <stable@vger.kernel.org>; Tue, 26 Aug 2025 05:01:21 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=msa.hinet.net;
	s=default; t=1756155681; bh=JBCbLQYoCHeAvUijnyWJT+nTyyE=;
	h=From:To:Subject:Date;
	b=VK0zuFZ1otC7av42wyw5kla4FgmmBYtmO6GHi67Bvdg3DUs1AC2yzQLBus84AVgAo
	 Pbwalx2WEP69qFydyHwOprpxPg4U8mZM6SkET1qRC7c60O1g78prceu5fP0alhq8BD
	 kC9NjO5ARBTlcxegoD1xfwNtzLM+HeawOD+nYXdI=
Received: from [127.0.0.1] (36-235-170-185.dynamic-ip.hinet.net [36.235.170.185])
	by cmsr1.hinet.net (8.15.2/8.15.2) with ESMTPS id 57PKvlUo934579
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <stable@vger.kernel.org>; Tue, 26 Aug 2025 04:57:50 +0800
Message-ID: <ba816d196ee0c5abb9f39ff1e50dc475b035cfae4dbdd70fbb960d8ea908609e@msa.hinet.net>
From: Sales <europe-salesclue@msa.hinet.net>
Reply-To: europe-sales@albinayah-group.com
To: stable@vger.kernel.org
Subject: September Quote - RFQ
Date: Mon, 25 Aug 2025 13:57:50 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=YdAe5BRf c=1 sm=1 tr=0 ts=68acce4f
	a=aHezKbDNoFXA/37C/7SvOg==:117 a=kj9zAlcOel0A:10 a=OrFXhexWvejrBOeqCD4A:9
	a=CjuIK1q_8ugA:10

Hi,

Please provide a quote for your products:

Include:
1.Pricing (per unit)
2.Delivery cost & timeline
3.Quote expiry date

Deadline: September

Thanks!

Kamal Prasad

Albinayah Trading

