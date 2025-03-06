Return-Path: <stable+bounces-121330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F09A55AD2
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 00:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2FE01775C6
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 23:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679541FBC9F;
	Thu,  6 Mar 2025 23:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delugo.co.za header.i=@delugo.co.za header.b="BRSBMEyY"
X-Original-To: stable@vger.kernel.org
Received: from outgoing16.cpt4.host-h.net (outgoing16.cpt4.host-h.net [197.189.249.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FB62E336F
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 23:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=197.189.249.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741303080; cv=none; b=m6z7LFhfikFPqk+RSk7J6gwP9I9WDSd84uXTOGS4VhuFwRvQI0IR+iTl2UdLjL6reHM0+dv3mE79t/n2c7jLgZ2iFp2gSQ1UxwXFJrJbWfi2LirfeaHRmRdodhEj9anhFTkyyUoU6boodV8ynzyDZueVKj8ifKa5TAKAdWcsrj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741303080; c=relaxed/simple;
	bh=UOdy1uc1Ja6Ouzx9Gp3orqw2OLpxN4Hd+lHG4CKFzvE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ofw0908BMRrtgTbJKrVDmT10b9bg9CbhXwJujFfmY+jLVeG7sOIxw8s7l/VIEA+qmCvxhZKepWzPfUwLEaDhIz4wrVcYYPrcb6uE+ZsmogUovZ5i7vwYmfXruD+DEB9eP2nw4CpVuYqT5zam4cu6+HF4Uj5psu3o9y1MlTLZAks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=delugo.co.za; spf=pass smtp.mailfrom=delugo.co.za; dkim=pass (2048-bit key) header.d=delugo.co.za header.i=@delugo.co.za header.b=BRSBMEyY; arc=none smtp.client-ip=197.189.249.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=delugo.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delugo.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=delugo.co.za; s=xneelo; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:sender:cc:bcc:
	in-reply-to:references; bh=UOdy1uc1Ja6Ouzx9Gp3orqw2OLpxN4Hd+lHG4CKFzvE=; b=BR
	SBMEyYYX2c0BFcNJoJyJ77Bd01cjMeL4UCyQQZ2luGk7+rDPofEm83Fp0RJiGFVrGdEngYpu1+Uhh
	G/Kd9gdj+EnOfQt4UuB9K1LsOyPYLGtxso7BCKDSaC4pDmoboEXyJ6IB4SHzXGYMBBzoO74PFcHJF
	/vy0GRbG6WaIHSBdWuRhcU1Na1gHE6TqIm95GJANorivDk4k13m7TCUuZ0u5IV83O+CECAJMf5JZt
	1WApCD4VG+K9fBrNEJoOpOp49SlvYFPfKp0mun4fqHkpZKkiYz1bHjMEEUyLuaOKNecAIexlErc74
	RalQo9NOrllhjVIQVECKgbtY+NmezP7A==;
Received: from www46.cpt3.host-h.net ([197.221.14.46])
	by antispam4-cpt4.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <orders@delugo.co.za>)
	id 1tqK5D-000g5V-0K
	for stable@vger.kernel.org; Fri, 07 Mar 2025 00:52:52 +0200
Received: from [104.192.5.240] (helo=delugo.co.za)
	by www46.cpt3.host-h.net with esmtpsa (TLS1.2:ECDHE_SECP521R1__RSA_SHA512__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <orders@delugo.co.za>)
	id 1tqK5C-0000000DmLM-1CUk
	for stable@vger.kernel.org;
	Fri, 07 Mar 2025 00:52:50 +0200
Reply-To: barry@investorstrustco.net
From: Barry <orders@delugo.co.za>
To: stable@vger.kernel.org
Subject: Re: The Business Loan/financing.1
Date: 06 Mar 2025 22:52:49 +0000
Message-ID: <20250306223012.5ACF2C556DE91C19@delugo.co.za>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Sender: orders@delugo.co.za
X-Virus-Scanned: Clear
X-SpamExperts-Domain: delugo.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@delugo.co.za
X-SpamExperts-Outgoing-Class: unsure
X-SpamExperts-Outgoing-Evidence: Combined (0.75)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+5DhM0jw86KsbkaGfFMuQCPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5xKnF+7I1sHya/mnI/qk7pcwm+8cezTviXvmgmQNTVFn4JL
 M0i5ZAms0EHrvcCaVIOIuDyoNAAk3S7wypr/MFEBzIXV52OyeiH3YVVX92r9xy+UMRGeTdEyZ1fy
 3Zt6lWCFcwLbxYAZ6mr+/0DiAFW6fePgajz63E7mJBgne4ugm4PAgTtUp75uqlx0KezvZHUGfc3j
 hBjxckGlDLNaHNFeWSnpHhzCpX6StWBDPW1xyi0n+6u17EFNvY1xrVxHOMjdaWolaEIooNu/YQK5
 hGs0PEg+PVRTiaxPY52n0Pp/86b+Sk5ZBXUgt9/X6plqv8Jl041btgY00t8ZwQGEpPru6KJwrbSo
 zGHLFB0eHc6erodzE47O357nyaNqjpIvt4xQef6Ceaw0tyEeHKZjklTreHL+whhAdKuW1jHRpIte
 tiiLAsB3YrKmt12KVBXn+lwYQsgkfE0ewNgNUY5lZOQ5++eDP+l2bcVgSchaWCsOR9QmV5Z+1S6W
 RsLXYNyKI5QBDLdZGhaGMngAFGniylMEqwf9bMTvxYH7osomSTjBYAs0fMdo6PLYRSf6dhUPyJaq
 j4ktAerpfvZQR+/GYrxkjlFvCdU5hCmT46F+0fdPU3buY2/zN9evqmMYUbFOXs5no3FEzj0O6u30
 2MX5S6wVT74ZEqLd8l9FM+v8+4kcTSFKbX6XRZLWB3ND0xLzUprzY+E/DeY4MRr++Q0vYxJYYVnn
 azKhbljZ0GZfwfcUVD2N5mbrh5seo3Henv1A21I8CVsONrMJuGzuoGnKTKcyxfHUzpDjDrEo6nxw
 LnwsWvr9keYPpbu7CWRAsL4If9OG1SA6Y19gzXA2SwLn5r9hdodBBMHyIG7/ydPVy6H/bn2rg3rh
 oTcTJt8uTKsMjek/gXktECu2zHJ/e9ivDnYnGw1uo0NPgp/w18bVcfCkCGRCocjQL9Td+ZGFmhHY
 C7oNAefjm6XnppQOmbjhLo5G
X-Report-Abuse-To: spam@antispamquarantine.host-h.net
X-Complaints-To: abuse@antispammaster.host-h.net

Hello,

My name is Barry at Investment Consult, we are a consultancy and
brokerage Firm specializing in Growth Financial Loan and joint
partnership venture. We specialize in investments in all Private
and public sectors in a broad range of areas within our Financial
Investment Services.

 We are experts in financial and operational management, due
diligence and capital planning in all markets and industries. Our
Investors wish to invest in any viable Project presented by your
Management after reviews on your Business Project Presentation
Plan.

 We look forward to your Swift response. We also offer commission
to consultants and brokers for any partnership referrals.

 Regards,
Barry
Senior Broker

