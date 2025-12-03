Return-Path: <stable+bounces-199914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3701BCA189B
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 21:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4FBF300C287
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 20:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4103F2BDC05;
	Wed,  3 Dec 2025 20:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="gTjQbCba"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CBD3207;
	Wed,  3 Dec 2025 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764793287; cv=none; b=KUjDdjowYMfbqQ7A8s9Dm1CwSpPGI+bIgN84SR0CWdrh9OBouX0U33iv5eVODkl1NR9fjcanTAOUlo5p+/PHldWdUWqPpGImYg4j77yR/MDSA2lwXmewHX/sBn+6opi/SF/kaPFNeTo3vGjrLJiwl3svYQBd9tMjkniCer87mpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764793287; c=relaxed/simple;
	bh=vVsBaXkkDdZQwoeWoNamrpBsg++LCJ8SfRzlkysRvOA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tf/MfOH5IxjTiRlYDnMIpgiFGrgIc6xT3ZER7jCzf4am8517ANOrMalaZ3xPKyYb7djNkTtc3qGkN19i8hT7zRurtuxDI5B1HpZacktIx+gYajs6QTCAlCLXMrgm566STkK8qP1u+OqEq8lWLCZMi/FZvws0UtxxkVR9R+1/s9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=gTjQbCba; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1764793279; x=1765398079; i=w_armin@gmx.de;
	bh=cjzs+irbPEAqadvDriC5TjO4PwulR1K87siZn2fCkYA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gTjQbCbatRw1rDL6NG2sCPLZ7q+pM8lRUNL4pDYbDkXv+RW6i+pQvGNCbqCdVK9b
	 ioP9lF0ggAogyoGamh8pv0f2jeeAUDxrVCeuc82FAekbobYPL9qv7u4kCj7ym/pZE
	 o5WLtbf0pc2N1cX4MMfSosZ+pMZbuo6KADl2WyJCtrdRiAY/yMwYCrlDJieFrFPAJ
	 7rsUiEg1Pk919mrZEB8Vu1fuzMbICmc56U+NdiWtEz4hNk+kx3Zh5x45CR6zy8BXY
	 Oe2spWHqIEvwI8CrfhjpFUFtuHErMdV3rk98Q4NJZUYaSXN0uenDo4aQ1Wdqv3bqd
	 HjTAVMhMQlw+mICIRA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M6UZl-1vOwKt2mE5-00H3ba; Wed, 03 Dec 2025 21:21:18 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: pali@kernel.org,
	linux@roeck-us.net
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] hwmon: (dell-smm): Fix off-by-one error in dell_smm_is_visible()
Date: Wed,  3 Dec 2025 21:21:09 +0100
Message-Id: <20251203202109.331528-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3l5ZddInVt2iIZpGzoefq86Pg6S1/CXgMzlHeLM9slQLk0YvDOw
 H8aW/q7S9qxbMWPkzP0zhe8yl61utPhRaL3t19C/Jecj4ZpRWO+ls8NSLsNK6YPiaoZ5LVW
 ItgV/jbBKvvwnRJ7IhCufixuzb7w9aWR+coYb/Ji5kG4uggq+oVeo/gKzJx4rLv9/oyp0N6
 mQswurPdpddIn/ofIHgoA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:d5GNiS5lNE0=;uOKZXRiyrvYy1TNTGUF16pVENK3
 PSdXOBvFyFUI6HFPbjjajehC+ZYlRzV9vSOFTelCA+eosq5Hwk4Fhx8dEiryv850tTG99FKW0
 GTwXfxgAHuqZWfrSTtbS9PsVrevXtCuIYLM2d0dHA/q6sBW7Fu5lawzTCV9Rj3xuXy3G6wURK
 q9FWxfFn0MQZLoxRMEmDDfDFZfCnRZxheXWbKAtxq0aTnzRV4RfZCk51/owjKmZDG7/nQ5bR+
 reGTspszq4PvNVOuxhbF6ywZchmHOJp7hpttob/eSkLmesyWCIIOoDmAFkdT1ba1BjFFXvbKd
 qzu0MvC3mHzxXp0p0LuGc1gg6wtYaCm4V7mjapPT5c+wzivERl83AmeEXkStNJqw+9oj4i3OU
 Cm2zzvS/7kKY5I4U1Jn+5Vx1eHXSMZT1hyDd32bzJLT6cI+gMiIlWsWwSiwFy/UAvd7eRFYfR
 8ruDypo/5saUN+DF74SpLhWIBppWcY7/dkLsvD40XI+J8/N2uiSlYkzdaA2SfnaEt0JYdGgVt
 UkMA3OYdcpkfE4Xb+A/nKeh6ZKs6R18835Zp49AsxLeZNBTDol32BvIoTppCTSVUWMAz7m2OR
 de34FFE8Brttk7OD1DXVEaNE0e7/F37A3gEOQTzMs6MFIXG2C8ARw0jTttuDD772Vrj9KBy6p
 /kteMSV0f00+TBnujQ7IUQr5G0c3KkIRMvgeNvBueVYDKGA3VBai/sxN7r8mdFHRv/YruHE+D
 nQEfJYr07UE08Dott5VodSw85BtQGEX3pctNkuyc8ZNnD5/1p0B0IpYLcPes8dbo4bK7UymjD
 H/2tj3NLRgyzpbvEJYf6x5Rt1Cd+ZfEZqSqfTAvFhlOjU/pmaUwp5YOlhnd7eULqTcwhiMMre
 UDKYEvxjBIXj9pgdayKGF5195g7OPyM5vheyaa0izFg8fEMSj0gAicwh3yo0Ktu0z5c6njFhJ
 PbdSkiiy/ctXthFeW+xYJ4MvmEfnigk2Fprl21l4Wfpa2enEvPNZt3zGbKEA1ybXcUaH9ZYRZ
 kjsJ4Ybx2SOK+v0F/0b1KO5cJ3YG0v3W4dGMIBPdW8MJZA4LwB9nqnV7uJM3lGlxd8DafRu0a
 bht7jGfes6kgo+EcW9v7ShJUD5TwuYoq4+pqYJ/3qQY200zwQOGMn2iD+Z5kG5tZ9la5HNeOz
 +NQoWHbm53pTiuTE2t65ra3QKmGLK9F+xkPHzMHBo7KDpsT/VF9uskPVQF4gZggn1nokK21o1
 2FO0M4gTWHckBx4ZeDt2XlPIfTbQnIJIQc7HoUaFE6HErEjIrD2eKimtMUUNRK2MnXguL9E+V
 ASK5ufxvdO294JqhoOAak/nu2kGNV5bG4zb/gTkdBKQryOyVuL9o3faLAqh7tXC/NQ8wVCZ/N
 KzYoPJRWAj0/okNgaRYj2AqTD5PoMistPWhSDWbqlI2FzqoyfvDIA6tQfQaVj6FQhulGs+ww0
 aWpWFDAHzSWlu1cTmoLui5EcCsIaVnIVE+R9kS7qMJBOigiqAfdwtc+MQAtc46lOcx+FGVP77
 a0tHI8Sr1EFZxJMyyMS32JJEnE00HuIixlnyvQnFh8n152tqdGekRbmeXRkpEigYS83hYYhL4
 PnxxDXtwj6dnS/UoXxm2YNEonYPN6iqpLgeTkGJMWg5qT9A1jxqdQlgRrgyfJ0xcru4YNrLR8
 K3F5yY1AwgZNMAYoOMr90PIL1EZrOFPYxgYbQmIyyaanCj3KiqJq4fvs1udePutVIBXdWWP/W
 G1Fv0Sj+FBp95A2wX4BWHGBp8FDGinghTc7MZAD77AAMtTiDjFDp88yx5bzVLZrMWltiAAH/D
 YB6VktxFpREK/XIjdDtvZluhuPNHuOi9C+eBBZwToNJisR0YP2QbOLiYhL17Fl77tfHkF+cW3
 jw/m1yu2rtfeXloIqHkkz+2+hGbLcd5dVL2U3F0zmls4qEMlguwCqIsZ/ozRcVlK9iBH+B2gT
 EZuxbpFHdhPmGun+pQarGm2thoOKbQ3tKz4pTqXNFk3IvcjP9xZO0SFEEaW4itvKnzs0gPrJv
 NPiMwftvOQkIQyX87yCIXplADiULygAq3u/ReP39lkhr80tMPLxenFzfw4pd6RLs3yWk9Irxg
 u5fSU7ogT7loghjWBAaUJyH8HY6HWSfUcln+Ome7AOKdXEJcAnEng17KZ0lh3ajUKFQ2+foEV
 JK5D1xPIAkRL8cqkNYbMHCzVvy4IWUNWvK1SiLdA9f+jw++uXB6oecJis9NVnUWjo729gpH7D
 ZYrISDejdu64WtRGUzL6oxOE+JEn7yLag5xNLj2Kpn0slrtvAIiY2VGFoOI+/dO4AyhCLtO++
 l10fZxBLdknak71NBlSUi+2Hrh10HOoskmWrLWnQwxS3LWWDh8dRjDquGZV8tPZeVtiBTbdf7
 t6DOdKIuvP0BOYRfXChP7ger7OLVgkYSGm4Jn1v4rWVVR+Tqz13ADeOr4pKrRg07IMPdbLNKV
 sbxo1bm3E0C7Eb85zHmm6+GqBGdAffVK0X5PvIIPH54/vaPdFp0ezGMGrNH7LxMtLQK98Pyvn
 pc9g5Qxh3ZKnOwrxpyTZTAopiCH4Fm6G/yDmocaOW0bBxhQDQIzED063R3f7Ql7cGEXThah2K
 dwv2po9M/5wAyJ0dk+y9aho6KNP4WRfXdfmuhcqSBlnTEzpUzBLrbYvz5CHNvOwRxMpl89OU7
 LUjEffk8ewRWIMBQVLvcpb0TNEU449OVyqV1LmTV1EB6qR8wfFZDppIml8uZZxWtJ/9vxkKb+
 rbro0cAPQhxqT49LuVC+fdBX9RSAt1TR5Z8rXO/imulAV+NsrtWLMx/MC0IOOBnb18kXtD8Ok
 oANVqrHolsYy6+hMUo0qqOvug53Yyyl4nFrBokbx1+bqF/T2HYkUmC4gREMbAMEwL7TF8xaKO
 BsW4pMCnUbyWWG0qF+es0wtjr45rn8UJnVsDZ+1QZeWL7JORnnwuPMAq9ekE5RDX0iBN2phav
 x5v++FSRoBb4qXB5NcQXavKVCm3kYeHQ/NxkBpDS7YzzGbBKbSKniVWY0fD/KY3fOvvR5+NBl
 6SORJRGuV6S7JbMiBNsfQgve8o7g6paw64MH1ziATvZZ67EwVJdJE0P2QXDuaKn+SGoac04r+
 o2Hz7uczx82H+nj4o3hBzujcQ0QxHKDIwZG3Y8pJZyCHKiAmXcMZnKPONfzfyj8ytCIwCzyvd
 rNinJN/Q3oWk3UobcsKsUKrosR4vmsQRpgqOiryw8sHv57hvM1LH3UfRqMFASZFZ1t6MK9t78
 N9yYZHX1lQxyE6iGQX+vWkNPzMtKaMaG4fnzmRS1H+6AEh+w5KFE6wVn5moMKGCzdGgEFT6LR
 ccVJBrLbn8vidigWpH2mnpTR/w9G5E0wfWMOxrZJB+uvb9PAIbmMdFEUZKBZASXbgtZviZoa1
 4b9jfWcGpieiTgSmDOPcjRzuAi75ltcfEomlnctbRkN2MHpdkdPQCef1G9WvtHvGsJGleUy53
 XmJ2DEd5BGkqpoemJ6AsrMQBTIk7vUXYBhnl8S9h3H2rcfNPD1M5dkt5oiFvGQ299SqLSv+Wr
 4/SEScOD0IFh7uRgO4Fo4q1JYza0ycm51jV5o4vinmCtc3YXxJYGqpz42wbizJBiRhJbLo8CX
 I6Dkkz7vJblvOTeKgVAwn+GmdQKEJ1Y3qqHNFEEhYkXeFcNbFvd1OFE7QlXKQAn0SbUNvvtk4
 oUzcvE1QEB/qKH66HwZOncyrM46YEWAM9PyWAAGd16YycGgoaRd/PH/JS9VdooeIRtsCQXl9d
 /cPUKPRSJePIyNl/0rcNTOjXjcbGHMim4+TBEZNhr8RFtE9tPrwfXhhCbtC6417MdLuAPjO5K
 wAcVudefL1VbIaut8eQQIejFzv1QfztTXKrWklVXYSBl9b/Gto7gnVrGRsqXaPzror83xYQiH
 Mk5ERPYr+fHjplr7jgQthMQQqLkA8TQmrw8CpLiEgvFwBZHa/41AVpyoTcXAJXC6xU6q18UZy
 S4iynXpLtRYlxRFTDxLwtotZ6seUiNyRBQCxQsuiyaUMvHc8wfcEhQiTb7qJ9vHP0/B65OhPW
 YYf6k4dLz9wODUS5T8iMk1zqKu6ua/j69v1EzQ8IZ9Bm5FWo08nNB5oR42eFJJmGRYaYNbXi/
 aqFWCLiyszkX2c9Sa7R0nT3eNPJALiiHcLlRgonowy7GP9cvUsvvj4nWSNxnXc1LyVHqNjbUu
 T6kWh9fwfCcJwKNcgfBfxPjKrBmnfZm0Q7upJhKOxuL+y9m8chE/X+7vOgCxrlbV34WfRhgCZ
 kO+u0eHMnfkaPaAej6lGFFj5hvIZJJIhFWl34e2I0BarTgDyUjbjjuIXLNrY7Ilncu7W857bs
 qMU/5/p8KLrdvO5UGJtpWIgLds/BgYKxz5GUsl5Od9P5Uv4P5bM03hrkhI42GPVi4sJBSfZaz
 443ZTSrjV7qVAw4/yBSjwR9dF/6pljZYonxj6bgApUCQMSB9i1i4hZ5bSZyQX8H+IP+hk2ykd
 iiGk3v3T3K4X728VzYMdrErX33wEIt/RUtpaF6KpsqX6xsVCWA9V5nKEoAKbqOxt7i8NWSggY
 bi8faTAHtc3yumI+POJZO8skzfA6lhy8vOZgx9A5QgvJ1mpcISJkIkQkOCly0RfAiyAWB2OmN
 uhoE9Z6ZzivG0DvTQXoljLE2GIBM/1+xbYcKQXPHi6O6ILOvyki1msIFvnNWGwwwM9H+HYt/Y
 mEO67TFp+lArPX9mkZQYuuBoPwbAelutsfZ0sqIgkSRplrxE6v1VQgDInaQRWZ4nkj50nTla4
 QUnTF67I9vbzg0BuAtJxl+QEfoAIwCWuEtaZA9Ad6oeFax8Wh0cUQWL/AAzqLnSRbkEkW7hwB
 X6zA7kjjduOK7IdF2oBmRO5A8Tmm+XkvehRkGNgcgzQZGK6fWbmNUNyhgfeex08Reo49IHo/R
 2zJdvbkRWSK/qSSfQ5HNn52NvyHm8/AnpLyihIshkhrUH73ThWvUxHX8SJOdtE7+p6t8NTX/f
 4Hru6Hh7ipecwzUYjP/BJPjYk+6qaAIeKCrGX1lm0eRO5bTGMxv7VgYmX+mlp8ZvATxllYklw
 xKvY9M4bk2P6LolUcWM0jQNZyyQjC1mnBDuK3mtBBma5+jzF4rgDW3hAB3C8VFuaB7xrOHaME
 zJYxAlOWJiKnrbFudPitA+d4xfrDcJES7t591j

The documentation states that on machines supporting only global
fan mode control, the pwmX_enable attributes should only be created
for the first fan channel (pwm1_enable, aka channel 0).

Fix the off-by-one error caused by the fact that fan channels have
a zero-based index.

Cc: stable@vger.kernel.org
Fixes: 1c1658058c99 ("hwmon: (dell-smm) Add support for automatic fan mode=
")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 683baf361c4c..a34753fc2973 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -861,9 +861,9 @@ static umode_t dell_smm_is_visible(const void *drvdata=
, enum hwmon_sensor_types
 			if (auto_fan) {
 				/*
 				 * The setting affects all fans, so only create a
-				 * single attribute.
+				 * single attribute for the first fan channel.
 				 */
-				if (channel !=3D 1)
+				if (channel !=3D 0)
 					return 0;
=20
 				/*
=2D-=20
2.39.5


