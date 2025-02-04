Return-Path: <stable+bounces-112146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB42A272BE
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 14:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523121670D3
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 13:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07417212FAC;
	Tue,  4 Feb 2025 13:04:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from listy.pwr.edu.pl (listy.pwr.edu.pl [156.17.197.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFF520FA81
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 13:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.17.197.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738674262; cv=none; b=bdirMupbL5P4g8XBGaZq7AWZCURQlLgh7LUwl7Z7pe++SLC5yYxz5owZ+Z1ZJYPBlNTkvoYZFsGVenVXYMK8vafSjxBOYi04PGatqEwm3OsliAmb5PI1KwrQhAa9KL8CHhZGHVM9tjAwHRXWBB40FdVXVlaWQLx1V74lNyj8x2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738674262; c=relaxed/simple;
	bh=XTy3ZrehLz8ZuJmLLkxVPpMA4xmPDLc3Yh9PbiZCvRM=;
	h=Content-Type:Message-Id:From:Date:Mime-Version:To:Subject; b=pFuyubDrgyOHG1pgPPPLb33e1fgCzpcwUvzLhYqnYfewt/QWDMA0cRwy9Tl/amVEIi6JPp28efqlQ9PWSjFf2xrRJpAQH8/3eI7/OD35+Te/4/96ShUQJUuyOlGraEFGp+SYUTU5g0LGNxFbdOwDEqQG6p2y8FzuwBBYs6vieXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e-informatyka.pl; spf=pass smtp.mailfrom=e-informatyka.pl; arc=none smtp.client-ip=156.17.197.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e-informatyka.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e-informatyka.pl
Received: from localhost (156-17-130-43.ii.pwr.edu.pl [156.17.130.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: e-informatica@listy.pwr.edu.pl)
	by listy.pwr.edu.pl (Postfix) with UTF8SMTPSA id 8C514404AADC
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 13:56:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 listy.pwr.edu.pl 8C514404AADC
Content-Type: text/plain; charset=UTF-8
Message-Id: <1738673772575963690.1.5937373815482959928@listmonk.example.com>
From: "e-Informatica Software Engineering Journal" <e-informatica@e-informatyka.pl>
Date: Tue, 04 Feb 2025 12:56:12 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: <stable@vger.kernel.org>
Subject: Publish Your Research in e-Informatica Software Engineering Journal (IF=1.2, Open Access & Free of Charge)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-Listmonk-Campaign: c3d88966-bba6-42ee-af4c-3eab7d6d221c
X-Listmonk-Subscriber: 0febfbc1-5610-4c07-8204-e30a97adbdc8


Dear Prof./Dr. Table,


e-Informatica Software Engineering Journal (EISEJ) is an established,
peer-reviewed, ISI JCR-indexed journal with an Impact Factor (IF=3D1.2,=20
5 Year IF=3D1.3) calculated by Clarivate and a free-of-charge, open-access=
=20
publishing model that accepts papers in Software Engineering, including=20
the intersection of data science (AI/ML) and Software Engineering.=20


Since you have published your research results at premier software=20
engineering conferences, such as MSR24, we believe that=20
EISEJ can serve as an excellent platform to share your impactful work furth=
er,=20
connecting it with a broad, engaged audience and enhancing your visibility=
=20
even more.


Why choose EISEJ for your next publication?

- Reputation and Trust: Indexed in ISI Web of Science (IF=3D1.2, 5 Year
  IF=3D1.3), Scopus (CiteScore'23=3D2.6, CiteScoreTracker'24=3D3.3 and grow=
ing),
  DBLP, DOAJ, and Google Scholar, demonstrating our global reach and
  credibility.
- No Author Fees: Publish your work under a CC-BY license without any costs=
,
  making your research accessible worldwide.
- Global Reach and Recognition: Internationally renowned Editorial Board:
  https://www.e-informatyka.pl/index.php/einformatica/editorial-board/ .
- Efficient Publishing Process: Benefit from continuous, rapid publishing
  with immediate online availability post-acceptance.
- No Restrictions on Paper Length: We welcome comprehensive work without
  word or page limits.

What We Publish:

In addition to regular research papers, EISEJ is an ideal venue for:

- Systematic reviews, mapping studies, and survey research studies,=20
  and supporting tools, see, e.g.,=20
  [1] Norsaremah Salleh, Emilia Mendes, Fabiana Mendes, Charitha Dissanayak=
e
  Lekamlage and Kai Petersen, "Value-based Software Engineering: A Systemat=
ic
  Mapping Study", In e-Informatica Software Engineering Journal, vol. 17, n=
o.
  1, pp. 230106, 2023. DOI: 10.37190/e-Inf230106.
  [2] Chris Marshall, Barbara Kitchenham and Pearl Brereton, "Tool Features=
 to
  Support Systematic Reviews in Software Engineering =E2=80=93 A Cross Doma=
in Study",
  In e-Informatica Software Engineering Journal, vol. 12, no. 1, pp. 79=E2=
=80=93115,
  2018. DOI: 10.5277/e-Inf180104.

- Guidelines, see, e.g.,=20
  [3] Miroslaw Staron, "Guidelines for Conducting Action Research Studies i=
n
  Software Engineering", In e-Informatica Software Engineering Journal, vol=
.
  19, no. 1, pp. 250105, 2025. DOI: 10.37190/e-Inf250105.
  [4] Muhammad Usman, Nauman Bin Ali and Claes Wohlin, "A Quality Assessmen=
t
  Instrument for Systematic Literature Reviews in Software Engineering", In
  e-Informatica Software Engineering Journal, vol. 17, no. 1, pp. 230105,
  2023. DOI: 10.37190/e-Inf230105.

- Research agendas and vision papers, see, e.g.,=20
  [5] Michael Unterkalmsteiner, Pekka Abrahamsson, XiaoFeng Wang, Anh
  Nguyen-Duc, Syed Shah, Sohaib Shahid Bajwa, Guido H. Baltes, Kieran Conbo=
y,
  Eoin Cullina, Denis Dennehy, Henry Edison, Carlos Fernandez-Sanchez, Juan
  Garbajosa, Tony Gorschek, Eriks Klotins, Laura Hokkanen, Fabio Kon, Ilari=
a
  Lunesu, Michele Marchesi, Lorraine Morgan, Markku Oivo, Christoph Selig,
  Pertti Sepp=C3=A4nen, Roger Sweetman, Pasi Tyrv=C3=A4inen, Christina Unge=
rer and
  Agustin Yag=C3=BCe, "Software Startups =E2=80=93 A Research Agenda", In e=
-Informatica
  Software Engineering Journal, vol. 10, no. 1, pp. 89=E2=80=93124, 2016. D=
OI:
  10.5277/e-Inf160105.
  [6] Einav Peretz-Andersson and Richard Torkar, "Empirical AI Transformati=
on
  Research: A Systematic Mapping Study and Future Agenda", In e-Informatica
  Software Engineering Journal, vol. 16, no. 1, pp. 220108, 2022. DOI:
  10.37190/e-Inf220108.

- Interdisciplinary work at the intersection of Software Engineering and
  AI/ML, see, e.g.,
  [7] Miros=C5=82aw Ochodek and Miroslaw Staron, "ACoRA =E2=80=93 A Platfor=
m for Automating
  Code Review Tasks", In e-Informatica Software Engineering Journal, vol. 1=
9,
  no. 1, pp. 250102, 2025. DOI: 10.37190/e-Inf250102.

We are also open to proposals for special sections that reflect the latest
trends and challenges in the field. If you have ideas for collaboration or
suggestions on how we can better meet researchers=E2=80=99 needs, we welcom=
e=20
your feedback at e-informatica@pwr.edu.pl .

Explore our journal at: https://www.e-informatyka.pl/ , and start your
submission process at https://mc.manuscriptcentral.com/e-InformaticaSEJ .

We recommend using our latest LaTeX template available at
https://www.e-informatyka.pl/index.php/einformatica/authors-guide/paper-sub=
mission/

With best regards,

Lech Madeyski & Miroslaw Ochodek
Editors-in-Chief, e-Informatica Software Engineering Journal (EISEJ)


---
EISEJ is indexed by:

- ISI WoS with Impact Factor (IF=3D1.2, 5 Year IF=3D1.3) calculated by Clar=
ivate:
  https://jcr.clarivate.com/jcr-jp/journal-profile?journal=3DE-INFORMATICA&=
year=3DAll%20years=20
- Scopus (with CiteScore=3D2.6): https://www.scopus.com/sourceid/2110025950=
9=20
- DBLP: https://dblp.uni-trier.de/db/journals/eInformatica/index.html
- Directory of Open Access Journals (DOAJ): https://www.doaj.org/toc/2084-4=
840
- Google Scholar: https://scholar.google.pl/citations?user=3D8-uDLDoAAAAJ&h=
l

---
Opt out: If you do not want to receive further e-mails from us, please use =
this link:
https://listmonk.e-informatyka.pl/subscription/c3d88966-bba6-42ee-af4c-3eab=
7d6d221c/0febfbc1-5610-4c07-8204-e30a97adbdc8

