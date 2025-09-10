Return-Path: <stable+bounces-179197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFC4B5162E
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 13:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2EC3ACB9E
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 11:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB0128641D;
	Wed, 10 Sep 2025 11:56:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from listy.pwr.edu.pl (listy.pwr.edu.pl [156.17.197.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A0528725B
	for <stable@vger.kernel.org>; Wed, 10 Sep 2025 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.17.197.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757505388; cv=none; b=PSwd4Gxn/qAXt+iYBI0JRKYtcNeIgvxbYtx/RW66BKepJ+eBJmQLpmt/hiQQz06PoKiN8aVHFpD4mCGD73ext+MmGxrA6VfAF4TEEvsHuNQhBWNYuHhwCMKm2o5tH+nCzUnXYRvyE8zWPoTVGD1H3UcBrSFb1v+fOGZF+iEmJVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757505388; c=relaxed/simple;
	bh=dcWCyM+66f0XswoND9Y6rdbD3JM9vEozAJpglWfn2NA=;
	h=Mime-Version:Content-Type:To:Subject:Message-Id:From:Date; b=lI23YDgjZA2WRsy6f9xq3mIfUcSeDW3cyVEM8O29QZFbVoG7RHdYSCGcVCG4O7wkeqMFhmi57jIg3WIQgLlhXf53jTRnkdIcfYnW+PCIUNddRaG9WE3PB7CnCz7F+ux8vO9Di8TWzQHMW7qaCHMlHQh0T9AUpCvIBPZuzoh9KHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e-informatyka.pl; spf=pass smtp.mailfrom=e-informatyka.pl; arc=none smtp.client-ip=156.17.197.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e-informatyka.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e-informatyka.pl
Received: from localhost (156-17-130-43.ii.pwr.edu.pl [156.17.130.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: e-informatica@listy.pwr.edu.pl)
	by listy.pwr.edu.pl (Postfix) with UTF8SMTPSA id 331E34048DA8
	for <stable@vger.kernel.org>; Wed, 10 Sep 2025 13:51:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 listy.pwr.edu.pl 331E34048DA8
X-Listmonk-Campaign: f884ba71-56f3-4ced-80ef-0b7a3ade467a
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Listmonk-Subscriber: 0febfbc1-5610-4c07-8204-e30a97adbdc8
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Content-Type: text/plain; charset=UTF-8
To: <stable@vger.kernel.org>
Subject: Publish Your Research in e-Informatica Soft. Eng. Journal (IF=1.2, Open Access, Free of Charge)
Message-Id: <1757505074208076255.1.1588249100032180833@listmonk.example.com>
From: "e-Informatica Software Engineering Journal" <e-informatica@e-informatyka.pl>
Date: Wed, 10 Sep 2025 11:51:14 +0000

<!doctype html>
<html>
    <head>
        <title>Publish Your Research in e-Informatica Soft. Eng. Journal (I=
F=3D1.2, Open Access, Free of Charge)</title>
        <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Du=
tf-8">
        <meta name=3D"viewport" content=3D"width=3Ddevice-width, initial-sc=
ale=3D1, minimum-scale=3D1">
        <base target=3D"_blank">
        <style>
            body {
                background-color: #F0F1F3;
                font-family: 'Helvetica Neue', 'Segoe UI', Helvetica, sans-=
serif;
                font-size: 15px;
                line-height: 26px;
                margin: 0;
                color: #444;
            }

            pre {
                background: #f4f4f4f4;
                padding: 2px;
            }

            table {
                width: 100%;
                border: 1px solid #ddd;
            }
            table td {
                border-color: #ddd;
                padding: 5px;
            }

            .wrap {
                background-color: #fff;
                padding: 30px;
                max-width: 525px;
                margin: 0 auto;
                border-radius: 5px;
            }

            .button {
                background: #0055d4;
                border-radius: 3px;
                text-decoration: none !important;
                color: #fff !important;
                font-weight: bold;
                padding: 10px 30px;
                display: inline-block;
            }
            .button:hover {
                background: #111;
            }

            .footer {
                text-align: center;
                font-size: 12px;
                color: #888;
            }
                .footer a {
                    color: #888;
                    margin-right: 5px;
                }

            .gutter {
                padding: 30px;
            }

            img {
                max-width: 100%;
                height: auto;
            }

            a {
                color: #0055d4;
            }
                a:hover {
                    color: #111;
                }
            @media screen and (max-width: 600px) {
                .wrap {
                    max-width: auto;
                }
                .gutter {
                    padding: 10px;
                }
            }
        </style>
    </head>
<body style=3D"background-color: #F0F1F3;font-family: 'Helvetica Neue', 'Se=
goe UI', Helvetica, sans-serif;font-size: 15px;line-height: 26px;margin: 0;=
color: #444;">
    <div class=3D"gutter" style=3D"padding: 30px;">&nbsp;</div>
    <div class=3D"wrap" style=3D"background-color: #fff;padding: 30px;max-w=
idth: 525px;margin: 0 auto;border-radius: 5px;">
        Dear colleague,

We would like to invite you to submit your papers to the e-Informatica Soft=
ware Engineering Journal (EISEJ).

We particularly invite papers focused on:
- software engineering or=20
- the intersection of data science (AI/ML) and software engineering.

Our strengths:
- excellent, international Editorial Board (https://www.e-informatyka.pl/in=
dex.php/einformatica/editorial-board/)
- *open access without any authorship fees*, =20
- no paper length limit,
- fast, continuous publishing model with papers edited and published immedi=
ately after acceptance,
- rigorous, blind peer-review process.

Our achievements:
- ISI WoS with Impact Factor (IF=3D1.2, 5 Year IF=3D1.3) calculated by Clar=
ivate (https://jcr.clarivate.com/jcr-jp/journal-profile?journal=3DE-INFORMA=
TICA&year=3DAll%20years),=20
- Scopus (https://www.scopus.com/sourceid/21100259509) with CiteScore=3D3.5=
,=20
- DBLP (https://dblp.uni-trier.de/db/journals/eInformatica/index.html),=20
- Directory of Open Access Journals (https://doaj.org/toc/2084-4840),=20
- Google Scholar (https://scholar.google.pl/citations?user=3D8-uDLDoAAAAJ&h=
l) etc.

Apart from classic research papers, we invite you to submit:
- systematic reviews (incl. systematic mapping/scoping studies),=20
- surveys,
- research agendas,
- vision papers.=20

We not only invite you to submit papers (https://mc.manuscriptcentral.com/e=
-InformaticaSEJ), but also to organise special sections (please get in touc=
h with us at e-informatica@pwr.edu.pl).

We would be grateful for your feedback as well. Please let us know what we =
lack, what we did not think about, or what we should do to become an even m=
ore attractive venue from your point of view!
Let us collaborate on any excellent idea within the scope of the journal!

With very best wishes,
e-Informatica Software Engineering Journal (EISEJ)
Editors-in-Chief
Lech Madeyski and Miroslaw Ochodek

EISEJ website: https://www.e-informatyka.pl/
EISEJ submission site: https://mc.manuscriptcentral.com/e-InformaticaSEJ
    </div>
   =20
    <div class=3D"footer" style=3D"text-align: center;font-size: 12px;color=
: #888;">
        <p>
            <a href=3D"https://listmonk.e-informatyka.pl/subscription/f884b=
a71-56f3-4ced-80ef-0b7a3ade467a/0febfbc1-5610-4c07-8204-e30a97adbdc8" style=
=3D"color: #888;">Unsubscribe</a>
            &nbsp;&nbsp;
            <a href=3D"https://listmonk.e-informatyka.pl/campaign/f884ba71-=
56f3-4ced-80ef-0b7a3ade467a/0febfbc1-5610-4c07-8204-e30a97adbdc8" style=3D"=
color: #888;">View in browser</a>
        </p>
    </div>
    <div class=3D"gutter" style=3D"padding: 30px;">&nbsp;<img src=3D"https:=
//listmonk.e-informatyka.pl/campaign/f884ba71-56f3-4ced-80ef-0b7a3ade467a/0=
0000000-0000-0000-0000-000000000000/px.png" alt=3D"" /></div>
</body>
</html>

