Return-Path: <stable+bounces-177503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB23FB406E5
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 16:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98C12080BF
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 14:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AEF2F39BD;
	Tue,  2 Sep 2025 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=editrage.com header.i=@editrage.com header.b="gykZdWtW"
X-Original-To: stable@vger.kernel.org
Received: from flamingo.yew.relay.mailchannels.net (flamingo.yew.relay.mailchannels.net [23.83.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105A83093CA
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823527; cv=pass; b=DV0MrkKUQXq7CHN7H8NaEQTpDTAHPHKIKRrRMgOsRnuhOEz10Je2KagL+MqIjvXUx0BbTx38TMpPncYBAZY54/3W+904CFt4BhJipe4UnqEDWKHw+EqEI0UZEyKkdYK89lxUCMOZXkiUo8yhU6tW56FNdvjYrIDHKsFjhllVVIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823527; c=relaxed/simple;
	bh=8bR8OFlLy2VUW1aqxbgV0A+FsjagdzUBElYDzmd68eM=;
	h=Message-ID:From:To:Subject:MIME-Version:Content-Type:Date; b=NoIpdpwcNt9gsvwzx7kJ8Of/EZnw3BNNYD7oXvVJWnwzbfIR5OqCSGcVbsOJnXYR9UmdCggYJiKeVfAuwvsxO7SEBB3DI+xcZ9Cdo7bUEQFqOzVy8hWt0lSIbg3MUaokiLSG+krOo2dPbZRXv1CXFiIr7JC8H6Wp5W3/zY+YE8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=editrage.com; spf=pass smtp.mailfrom=editrage.com; dkim=pass (2048-bit key) header.d=editrage.com header.i=@editrage.com header.b=gykZdWtW; arc=pass smtp.client-ip=23.83.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=editrage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=editrage.com
X-Sender-Id: hostingeremailsmtpin|x-authuser|care@editrage.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6FBDA844EE2
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 13:54:15 +0000 (UTC)
Received: from fr-int-smtpout19.hostinger.io (100-104-249-105.trex-nlb.outbound.svc.cluster.local [100.104.249.105])
	(Authenticated sender: hostingeremailsmtpin)
	by relay.mailchannels.net (Postfix) with ESMTPA id B83FA845E90
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 13:54:14 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1756821255; a=rsa-sha256;
	cv=none;
	b=StLaTNb5QBk6NIQG3giGqSudYkIF/TeQ2qAb+NbgUxtYyu2oPKlSOaAZ1TgaM1WoavjNU9
	hoHRuvXhRnoudS7Lq2M5mdKtmYIV06JLqr8YrDPGIHtKkYcoF9srpei3Kbq/YmwciJuxOH
	SVVQC21beK7EaKwg3a/aq+AAQFeoWX265ger/Ya4ZK8bcOwQtYe6xQeBNVXqhnCnvG5YCs
	bLqsORURAp0/TEQKRuG/3V2tguygJj08C7FnQL8C1cSEoZCAaFEljTNOUswVIyl7zg2LsS
	80oAyHMeqfB30KD81TIcCCJLf6H3LBRtAkji9tOD+fBNrkEfS+E3blKGFxA5yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1756821255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=8bR8OFlLy2VUW1aqxbgV0A+FsjagdzUBElYDzmd68eM=;
	b=Wrb51y1FLw0IMzYTQqVS+mw9jR648CEVBKQxWXyph/TUAs1xNYA4m2FlAVYe6oC95utohG
	E6UzZeaoA4/hYMjvRvGxMkTV7K2TkByZGC5vGmcslLqXeMwMv4KRARt7YKIvpgfsbPRmHB
	ePOfcx3ZIHFZX+aPV0FZ1/RppPuGDdENIIOZD3MJfPVKRhFY2/MzLNdVTitE7wqYu/No1S
	1iBexaYGyXyNJYxXm2YOQ8dif3VKiJSt2LQDXpTjfMweS8vwquIPToHxVXgBF/1c6g0QRK
	QXm35YE5D+RiqDlakkZD04v9Kc+NvL3VNCfch1eX1MgeauD3PceO/eItAxbc6w==
ARC-Authentication-Results: i=1;
	rspamd-9594d4cf9-kbhhh;
	auth=pass smtp.auth=hostingeremailsmtpin smtp.mailfrom=care@editrage.com
X-Sender-Id: hostingeremailsmtpin|x-authuser|care@editrage.com
X-MC-Relay: Good
X-MailChannels-SenderId: hostingeremailsmtpin|x-authuser|care@editrage.com
X-MailChannels-Auth-Id: hostingeremailsmtpin
X-Cellar-Invention: 0645889c78704422_1756821255255_4254369579
X-MC-Loop-Signature: 1756821255255:309123442
X-MC-Ingress-Time: 1756821255255
Received: from fr-int-smtpout19.hostinger.io ([UNAVAILABLE]. [148.222.54.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.249.105 (trex/7.1.3);
	Tue, 02 Sep 2025 13:54:15 +0000
Received: from 73b8c74f-fc73-4ac0-b19b-4cd38d0f2192.local (ec2-44-223-21-34.compute-1.amazonaws.com [44.223.21.34])
	(Authenticated sender: care@editrage.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4cGS046dxcz1xnq
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 13:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=editrage.com;
	s=hostingermail-a; t=1756821253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8bR8OFlLy2VUW1aqxbgV0A+FsjagdzUBElYDzmd68eM=;
	b=gykZdWtWARw69jy4tn6drxZksANh9SP0yFOZxFZsF56oD0cAPyoWBfsgk6bn2x9GerKWJ4
	LVsSLC2wHpZGxOHRtu5LvMQI1gdc3cyc5UCYXfmrHXPSMq0nhyjvHB1JbxdXHPkmEQ1J90
	fqRP4zKawEwbLGV2KqyR6WnxFCTOscc2uURGjUryUW2K6p6BUk3eZ9JyicsIThWfZJPUXi
	i6lNZrB13hqqxezVaGYWPkOOAM1NCqk4fY9Mpl6XQ7SSgYG7ste3zLS4WMXGidoX/JfpCe
	9agSbMkadRvXgtLGUE2QckQEJFawo2icsZB4+CSMKb8S/mAOd4/V8NUxXPMEVQ==
Message-ID: <73b8c74f-fc73-4ac0-b19b-4cd38d0f2192@editrage.com>
From: Mohanish Ved <care@editrage.com>
To: stable@vger.kernel.org
Subject: Truth: AI adoption in healthcare
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Date: Tue,  2 Sep 2025 13:54:12 +0000 (UTC)
X-CM-Envelope: MS4xfJEMtxRryI6xkSIrkN6J50j9wGu4v4FtFPvfAwRNuBzpTLAloejhPDmX76qJp/4wxmBFQGz5XpZSjeXCxlDjT20OgLDNrE/owAlnUpl+u3i1IXNULsHH f/eLzKlTxLefDVB0HRF7X+UaecXilFNNroEBzQk9Jt9xolMNEjeen/nBwBUANcs3n8ekxqvyKaL6lCiHpMnHHXw62o1G14D3RbVFJlc9eKxHclkMpkDb5o7o
X-CM-Analysis: v=2.4 cv=DJTd4DNb c=1 sm=1 tr=0 ts=68b6f705 a=1uyTlxNLEoEcdq9WtLNpaQ==:117 a=1uyTlxNLEoEcdq9WtLNpaQ==:17 a=IkcTkHD0fZMA:10 a=amsrZz8KWSJj8ufvzgsA:9 a=QEXdDO2ut3YA:10 a=UzISIztuOb4A:10
X-AuthUser: care@editrage.com

Hi Dr. Sam Lavi Cosmetic And Implant Dentistry=C2=A0,

AI adoption in healthcare isn=E2=80=99t coming =E2=80=94 it=E2=80=99s =
already here.
Some implant clinics are quietly using AI to handle patient =
calls, consultations, and scheduling.

Their growth isn=E2=80=99t a =
coincidence.
Being first gives them an edge =E2=80=94 being late means =
playing catch-up.

Should I share a 2-min demo video so you can see how it =
works?
Reply 'Video' and I=E2=80=99ll send it.

=E2=80=94
Best regards, =C2=A0
Mohanish Ved=C2=A0=C2=A0
AI Growth Specialist =C2=A0
EditRage Solutions
=C2=A0

