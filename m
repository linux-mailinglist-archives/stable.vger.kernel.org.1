Return-Path: <stable+bounces-37917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB4989E7A4
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 03:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906441C21676
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 01:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B731639B;
	Wed, 10 Apr 2024 01:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="kHClfu3U"
X-Original-To: stable@vger.kernel.org
Received: from a8-56.smtp-out.amazonses.com (a8-56.smtp-out.amazonses.com [54.240.8.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92ED10E5
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 01:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.8.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712711670; cv=none; b=SpYO8hMGE9pfAXE+FKMQM9K8LEeAR3qED8h7q6LQre5aw0bFFw57H1WcRGuWQq7ivtKvlmWSpYDMZWErtCo3V3sSnlUhXIFucT3Ps+1tkwCSS56hD0wd93wBnVraCnKqI9BrG4Eag+k/f5OXYk9N4nYhXIojNQi+7C+BrPqGexA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712711670; c=relaxed/simple;
	bh=9mFhJBrxK0yJooi7RxHb8K/wF/KsVQ0wnvGdBYrP1dw=;
	h=Message-ID:Mime-Version:From:To:Subject:Date:Content-Type; b=HnGYqTSLcpQBoKCujY+ZXhDbBgIZ+RUp+abA7l9AzrHfnu3DrPCEPcWX+BdwSNltqtc56rKBJWeOJiCw/+B6VdgTHfCD1TkgCD0VDyZoAge40PTYz1Vhz0AuMmoB93k1J/i8xvzSybEDNY6lQT7GO8wfko0nqYMsy1bDlKGglmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=westenenergy.org; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=kHClfu3U; arc=none smtp.client-ip=54.240.8.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=westenenergy.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1712711666;
	h=Message-Id:Mime-Version:From:To:Subject:Date:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=9mFhJBrxK0yJooi7RxHb8K/wF/KsVQ0wnvGdBYrP1dw=;
	b=kHClfu3UguRWAMcMxTah9lruwyU+kLjlJlrFrQAVLa6pfISSei8lus/PQVlplqGK
	KqujRPA4x4OdLB5HsS+GQ3Umze0AlS6stSxBuTeUBMxsQr2mjhtfMwsm+gIt8BeSXJZ
	2WSJyXITZ2q/s8PEZN0QKeEWG5VbOMj16tmHckPA=
Message-ID: <0100018ec5920b43-545e1181-6643-4dcb-97d3-5e71ceb6038d-000000@email.amazonses.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: Marisol Alvarez <MarisolAlvarez@westenenergy.org>
To: stable <stable@vger.kernel.org>
Subject: Late Filling (Extension)
Date: Wed, 10 Apr 2024 01:14:26 +0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Feedback-ID: 1.us-east-1.zZGt/1D27CYJaOtuycNrehBcMWCwjn4jTKQ4WuOpTyI=:AmazonSES
X-SES-Outgoing: 2024.04.10-54.240.8.56

Hello,

I trust this message finds you well=2E My name is Marisol Alvarez, and I am=
 currently in search of a new tax preparer for Extension=2E I came across y=
our services and would like to inquire about your availability for new clie=
nts for the extension period=2E

Specifically, I need assistance with the preparation of my individual tax r=
eturns, which includes Schedule D and Schedule C=2E Could you please provid=
e information on your fee structure for handling returns with these schedul=
es?

Additionally, I am interested in becoming a client and would like to know t=
he steps involved in signing up for your tax preparation services=2E

I appreciate your prompt response and look forward to the possibility of wo=
rking with you=2E

Kind regards,

Marisol Alvarez
Member Services Specialist

