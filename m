Return-Path: <stable+bounces-104132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FCB9F11AB
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 17:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5221886E9C
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE571E3DD1;
	Fri, 13 Dec 2024 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="EhEAHSVx"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC3D1DE4FF;
	Fri, 13 Dec 2024 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105536; cv=none; b=Y6rsc9vesJYBA07ygotXU7EmWcVXPLWaQyuE4dEzFJ9LbHsk+GxmVsOlSgmpfBIhET7zn5kDxHY0jpvyhGaYaNwcEc4FF9xPoWRHmN+hTko141dxwikVqtVYv5OtydRoiCSpkfQLPoeMtYeu0epDK/LDxbUiamDh/CuatlTzTDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105536; c=relaxed/simple;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=rsZE5GYSMJBzZ2fG5EKFDFmIaASEpV1JozGXoIW7yb7NSHKqkHLeNJhaVnCr8usigOQ55pW0WyKN70B6ge9NKuksiNZ+5e7r8a9XVRQ2lfY9T5a/zVPLUCz2I5jD26Tc48RDa9lAieLXGs4mLkW5q4j4bXwOTrGe5ExotDUfMCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=EhEAHSVx; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1734105531; x=1734710331; i=rwarsow@gmx.de;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EhEAHSVxe1ZFqTRSqUZq7UniWy6Fwfv2X99eGAXRBkkUt8+PwG73x+BoCRtxmysT
	 kte7xfJwWjvPK+2o0fxPUA8YUZ4fsTu3ZlDqjg8H1/sVU8JUIfvNEErEDAayvgRvC
	 9XctsggLhIlyv8HyPXhZxQdBSrKT3MXOeAlLTB4j2KFjGkX4zbAK+HhwxgS8qWbEj
	 YBtbfz7WNZke6VDV+hfI69FiWEF2ERUN30/P4qtT/qFf5qbO5islBnVjOZeDQSxYP
	 CrQe3uHgwiLswqNA11+/fmrVzbQUBTm77pYMVHusOygeHPLPH9SuoOKVGT80rsZAs
	 tIr/PPHmA7fn0ufEqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([46.142.33.232]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEm2D-1tPABd3q6F-002fy2; Fri, 13
 Dec 2024 16:58:50 +0100
Message-ID: <4965a11d-fa56-4802-904d-4df4d92db056@gmx.de>
Date: Fri, 13 Dec 2024 16:58:50 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.12 000/467] 6.12.5-rc2 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:iv1sbX93flrN6W4k3WdTwgQ7K6s3Y/KgvowIAUJ1x+FrOD0oQAI
 t+zh9+1j9opTFNfx3ZcNVc0WQG1BiP8E4NLtDvTPE/0r3c50T7ohGOlc0y8EXsIwNwqAiH+
 13Xsb4mWv94p+Pcreg4SN3ceW4yklH7KJYJbyIbRfMk6DmP+NCx3qZXH5u8LC67ua9cAOXt
 WTOLaoTIz6v2MBEg0DJUg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7ULh0vShYuc=;QuTtwYJpK50Jj0RYu9uahl/xr8i
 TUL+4ihhbFW8QYkMJJiWV2SiZl4kfMwUjf+6FrrLHz1yMHVmRrki5c7k7IY2wQ4e/Gjz47KZ3
 RYaCwjcf+NErObKgC0NEuqzaE+0HseVaZRkCdZ9UvrQ5CvoSM08LD1WwAyX23yVt42Tg2KTTp
 2fwvc9fSgilGBOSaqMccyVKlCcfpyyNnTyHXVwMCmbXP8CzHnOszW8E17wERbTleHki9/pO2/
 IhmGqkWYifv8mg4GS2T41Vtey8qQPR1l2f9oQLp5rmWOqSlj0GMeO8kIuOYFQ0KayBkBUfyGx
 M4VsgdECM0hGc3BeFgtJ0bx3+F9/DFjYTlMhIqm4iOCyRGLt1ZVi6NVpDZLxBcfWDrhwaiHgP
 K13zzx1Tua/d3Q3lAClKooIb9EGUBPQ9FBbNb9I0G6t/zRQfxut+WFF02IhooiItwOm3lOXrC
 FAfabHMeXpUEk7NIsAoys8nKDtDx1+5KqVmma2dOuRaZGbgRLodA3GCOi7qxyI7FPSpWjGIhp
 dfwMqOLMrEAdotcvnkC8KrcAH8VtBc2l5Gh1qo0ZGdybhrZMxrJej3bgPHkfdbR5mZJlnUGBG
 rmtpXSvwccyqEJCpeW4oPA+Q2N40t34+up4bhhlbjB80zPZVMDRnRlWZH/la/QMHxVeF6BjtI
 VH1jEcA9M6FZ7fV01HBfhiYVNeWKulz7wpBx2uEdaXqyV1ilWoMPqw/jIXmd2VIQORNADFmii
 BeuFQglTqD7E4CUbL6k5OdzW7Ey02BxOPo8NI2a1ZueV9PrBk+haOgXGHuUia2iw+94hcKt40
 h/wNqD6C9378VfDkGSdzse0TCIaYZ62OhnaUdD0PqiPg2SMz60qixxJPExNBXNWGzZnU0lpWs
 z91FMzs8qM0qjf91lYenaq/N0NZYLGniDOHGettbDNmBKY9l7EprjWTfAhz+Jck4xG2u15UBs
 RN/+n+utnth+rlV6+Ah5iafNAa2sUoCkAbY/d+ahYM+Mov0kmwLzmm8oV9LvLbFcGyDTnStoU
 BGiWOTL8eIK/ULwqKrbl7FyG50SRJaypMs1xhjXlPOd+ay7Sw903FUORnV0zyNjRsjhtEiqJr
 YHM1jEyQBWyDRSujJWPh3poqdCyjlW

Hi Greg

*no* regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

